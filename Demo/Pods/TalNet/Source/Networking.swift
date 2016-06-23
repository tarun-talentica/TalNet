//
//  Networking.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation

public class Networking {
  
  // static constant, that is initialized to class instance. This is created with dispatch_once block so it is thread safe.
  public static let sharedManager:Networking = Networking()
  
  // Make init private so no one from outside can create an instance of this class.
  private init() {}
  
  public func request(query: Queriable) -> CancellableRequest {
    let requestable = QueryRequest(query)
    return request(requestable)
  }
  
  public func request(request: Requestable) -> CancellableRequest {
    let mutableURLRequest:NSMutableURLRequest = request.URLRequest
    var cancellableRequest = CancellableRequest()
    
    if let query = request.query as? TokenRefreshingQueriable {
      query.refreshAccessToken(request: mutableURLRequest) { (request,success) in
        if success {
          cancellableRequest.makeRequest(request)
        } else {
          /// Fire the global error if any.
          /// Set error in cancellableRequest, and resume the queue
          cancellableRequest.markRefreshTokenError()
        }
      }
    } else {
      cancellableRequest.makeRequest(mutableURLRequest)
    }
    
    return cancellableRequest
  }
}