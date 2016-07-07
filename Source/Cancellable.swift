//
//  Cancellable+Alamofire.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 09/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

/// Protocol to define the opaque type returned from a 3rd Party request object
public protocol Cancellable {
    func cancel()
    func suspend()
    func resume()
}

public struct CancellableRequest: Cancellable {
    var innerCancellable: VendorCancellable? = nil

    var refreshTokenFailed = false
    private var isCancelled = false
    
    public init() {
        innerCancellable = VendorCancellable(request:nil)
    }
    
    public func makeRequest(request: NSMutableURLRequest) {
        innerCancellable?.vendorRequest =
            VendorNetworking.sharedManager.getVendorNetworkRequest(request)
        innerCancellable?.queue.suspended = false
        resume()
    }
    
    public mutating func markRefreshTokenError() {
        refreshTokenFailed = true
        innerCancellable?.queue.suspended = false
    }
    
    public func cancel() {
        innerCancellable?.cancel()
    }
    
    public func suspend() {
        innerCancellable?.suspend()
    }
    
    public func resume() {
        innerCancellable?.resume()
    }
}

// [TODO:] This class need not confirm to Cancellable protocol. Revisit it.
internal final class VendorCancellable: Cancellable, CustomDebugStringConvertible {
    let cancelAction: () -> Void
    let queue:NSOperationQueue
    
    var vendorRequest:VendorRequest?
    private(set) var cancelled: Bool = false
    private(set) var suspended: Bool = false
    
    init(action: () -> Void){
        self.cancelAction = action
        self.vendorRequest = nil
        
        self.queue = {
                let operationQueue = NSOperationQueue()
                operationQueue.maxConcurrentOperationCount = 1
                operationQueue.suspended = true
                return operationQueue
            }()

    }
    
    /// Failable initializer. In case where there is no vendor request return nil.
    init(request:VendorRequest?) {
        self.vendorRequest = request
        self.cancelAction = {
            request?.cancel()
        }
        
        self.queue = {
                let operationQueue = NSOperationQueue()
                operationQueue.maxConcurrentOperationCount = 1
                operationQueue.suspended = true
                return operationQueue
            }()
    }
    
    func cancel() {
//        OSSpinLockLock(&lock)
//        defer { OSSpinLockUnlock(&lock) }
        guard !cancelled else { return }
        cancelled = true
        cancelAction()
    }
    
    func suspend() {
        // [TODO:] Should we pass any callback to the caller. May be later....
        suspended = true
        vendorRequest?.suspend()
    }
    
    func resume() {
        suspended = false
        vendorRequest?.resume()
    }
    
    var debugDescription: String {
        guard let request = self.vendorRequest else {
            return "Empty Request"
        }
        return request.debugDescription
    }
    
    deinit {
        queue.cancelAllOperations()
        queue.suspended = false
    }
}