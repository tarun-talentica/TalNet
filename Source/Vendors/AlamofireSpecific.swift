//
//  AlamofireImports.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 09/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import Alamofire

public typealias NetworkManager = Alamofire.Manager
typealias ParameterEncoder = Alamofire.ParameterEncoding
public typealias VendorRequest = Alamofire.Request
public typealias VendorResponse = Alamofire.Response
public typealias VendorResponseSerializer = Alamofire.ResponseSerializer


//
//public extension StringSerializable {
//    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<String,NSError> -> Void) {
//        
//        request.innerCancellable?.vendorRequest?.responseString(encoding: self.encoding) {
//            response in
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                completionHandler(convertResponseToQueryResult(response))
//            }
//        }
//    }
//}
//
//public extension JsonSerializable {
//    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<AnyObject,NSError> -> Void) {
//        
//        request.innerCancellable?.vendorRequest?.responseJSON(options: self.jsonOptions) {
//            response in
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                completionHandler(convertResponseToQueryResult(response))
//            }
//        }
//    }
//}