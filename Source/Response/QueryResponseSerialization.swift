//
//  ResponseSerialization.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 13/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol ResultSerializableType {
    associatedtype SerializedType
    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<SerializedType, NSError> -> Void)
}

public protocol StringSerializable: ResultSerializableType {
    associatedtype SerializedType = String
    var encoding: NSStringEncoding? {get set}
}

public extension StringSerializable {
    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<String, NSError> -> Void) {
        
        request.innerCancellable?.vendorRequest?.response {
            (request:NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> () in
            
            func sendResponse(results: QueryResult<String,NSError>) {
                let queryResponse = QueryResponse(request:request, response: response, statusCode: response?.statusCode, result: results)
                completionHandler(queryResponse)
            }
            
            guard error == nil else {
                sendResponse(QueryResult.Failure(error!))
                return
            }
            
            if let urlResponse = response where urlResponse.statusCode == 204 {
                sendResponse(QueryResult.Success(""))
                return
            }
            
            guard let validData = data else {
                let error = Error.StringSerializationFailed.nsError
                sendResponse(QueryResult.Failure(error))
                return
            }
            
            var convertedEncoding = self.encoding
            
            if let encodingName = response?.textEncodingName where convertedEncoding == nil {
                convertedEncoding = CFStringConvertEncodingToNSStringEncoding(
                    CFStringConvertIANACharSetNameToEncoding(encodingName)
                )
            }
            
            let actualEncoding = convertedEncoding ?? NSISOLatin1StringEncoding
            
            guard let string = String(data: validData, encoding: actualEncoding) else {
                let error = Error.StringSerializationFailed.nsError
                sendResponse(QueryResult.Failure(error))
                return
            }
            
            sendResponse(QueryResult.Success(string))
        }
    }
}

public protocol JsonSerializable: ResultSerializableType {
    associatedtype SerializedType = AnyObject
    var jsonOptions: NSJSONReadingOptions {get}
}

public extension JsonSerializable {
    
    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<AnyObject, NSError> -> Void) {
        
        request.innerCancellable?.vendorRequest?.response {
            
            (request:NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> () in
            
            func sendResponse(results: QueryResult<AnyObject,NSError>) {
                let queryResponse = QueryResponse(request:request, response: response, statusCode: response?.statusCode, result: results)
                completionHandler(queryResponse)
            }
            
            guard error == nil else {
                sendResponse(QueryResult.Failure(error!))
                return
            }
            
            guard let validData = data where validData.length > 0 else {
                let error = Error.JSONSerializationFailed.nsError
                sendResponse(QueryResult.Failure(error))
                return
            }
            
            if let urlResponse = response where urlResponse.statusCode == 204 {
                sendResponse(QueryResult.Success(NSNull()))
                return
            }
            
            do {
                let JSON = try NSJSONSerialization.JSONObjectWithData(validData, options: self.jsonOptions)
                sendResponse(QueryResult.Success(JSON))
            } catch {
                sendResponse(QueryResult.Failure(error as NSError))
            }
        }
    }
}

public protocol ObjectSerializable: ResultSerializableType {
    associatedtype ObjectType: ObjectMappable
    associatedtype SerializedType = ObjectType
}

public protocol ObjectArraySerializable: ResultSerializableType {
    associatedtype ObjectType: ObjectMappable
    associatedtype SerializedType = [ObjectType]
    
    var keyPath: String? { get }
}

public extension CancellableRequest {
    
    public func checkForVendorRegistration<T>(completionHandler:QueryResponse<T,NSError> -> Void) -> Bool {
        /// Check if any vendor exists. If not then return an error.
        guard let _ = self.innerCancellable?.vendorRequest else {
            let error = Error.NoVendorRegistered.nsError
            let errorResponse = QueryResponse<T,NSError>(result: QueryResult.Failure(error))
            completionHandler(errorResponse)
            return false
        }
        
        return true
    }
}

public extension CancellableRequest {
    
    func response<T:ResultSerializableType>(
        destinationQueue queue: dispatch_queue_t? = nil,type:T,
                         completionHandler: QueryResponse<T.SerializedType, NSError> -> Void) -> CancellableRequest {
        
        self.innerCancellable?.queue.addOperationWithBlock {
            if self.refreshTokenFailed {
                let error = Error.InvalidAccessToken.nsError
                let queryResponse = QueryResponse<T.SerializedType,NSError>(
                    result: .Failure(error))
                dispatch_async(queue ?? dispatch_get_main_queue()) {
                    completionHandler(queryResponse)
                }
            } else{
                type.serialize(from: self) {
                    response in
                    dispatch_async(queue ?? dispatch_get_main_queue()) {
                        completionHandler(response)
                    }
                }
            }
        }
        
        return self
    }
}


