//
//  Vendor.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 18/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

internal final class VendorNetworking {
    
    // static constant, that is initialized to class instance. This is created with dispatch_once block so it is thread safe.
    static let sharedManager = VendorNetworking()
    
    var startRequestsImmediately = false
    
    /// [TODO:] If there is no vendor then this should be nil
    let manager:NetworkManager? = NetworkManager.sharedInstance
    
    // Make init private so no one from outside can create an instance of this class.
    private init() {
        self.manager?.startRequestsImmediately = false
    }
    
    func getVendorNetworkRequest(mutableURLRequest:NSMutableURLRequest) -> VendorRequest? {
        
        /// If manager is nil here then return nil so that we know there is no vendor present.
        return manager?.request(mutableURLRequest)
    }
    
    func makeVendorNetworkRequest(mutableURLRequest:NSMutableURLRequest?) -> CancellableRequest {
        
        /// If manager is nil here then return nil so that we know there is no vendor present.
        var cancellableRequest = CancellableRequest()
        cancellableRequest.innerCancellable =
            VendorCancellable(request: (mutableURLRequest != nil) ?
                manager?.request(mutableURLRequest!) : nil)
        return cancellableRequest
    }
    
    func encodeParameters(encoding:Encoding,URLRequest:NSMutableURLRequest,parameters: [String: AnyObject]?) -> (NSMutableURLRequest, NSError?)? {
        
        if manager == nil {
            return nil
        }
        
        var encodedURLRequest:(NSMutableURLRequest, NSError?) = (URLRequest,nil)
        
        switch encoding {
        case .URL:
            encodedURLRequest = ParameterEncoder.URL.encode(URLRequest, parameters: parameters)
        case .JSON:
            encodedURLRequest = ParameterEncoder.JSON.encode(URLRequest, parameters: parameters)
        }
        
        return encodedURLRequest
    }
}


func convertResponseToQueryResult<T,Value>(
    response:VendorResponse<Value,NSError>) -> QueryResponse<T, NSError> {
    
    switch (response.result) {
        
    case .Success(let value) :
        
        func convertValue(value:Value) -> T? {
            guard let value = value as? T else { return nil }
            return value
        }
        
        if let convertedValue = convertValue(value) {
            return QueryResponse<T,NSError>(request: response.request, response: response.response, statusCode: response.response?.statusCode, result: QueryResult.Success(convertedValue))
        }
        
        let error = Error.NoResponseSerializer.nsError
        let errorResponse = QueryResponse<T,NSError>(request: response.request, response: response.response, statusCode: response.response?.statusCode,result: QueryResult.Failure(error))
        return errorResponse
        
    case .Failure(let error):
        let queryResponse = QueryResponse<T,NSError>(request: response.request, response: response.response, statusCode: response.response?.statusCode, result: QueryResult.Failure(error))
        return queryResponse
    }
}
