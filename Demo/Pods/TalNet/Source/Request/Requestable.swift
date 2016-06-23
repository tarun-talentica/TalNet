//
//  Requestable.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//

import Foundation


public protocol Requestable {
    var query: Queriable { get }
    var URLRequest: NSMutableURLRequest { get }
}

extension Requestable {
    
  var URLRequest:NSMutableURLRequest {
    
    let components = NSURLComponents()
    components.scheme = query.service.scheme
    components.host = query.service.host
    components.port = query.service.port
    components.path = query.path
    
    let destinationURL = NSURL(string: components.string!)
    
    var mutableRequest = NSMutableURLRequest(URL: destinationURL!)
    mutableRequest.HTTPMethod = query.method.rawValue
    
    if let params = query.parameters {
      mutableRequest =
        query.encoding.encode(
          mutableRequest,
          parameters: params.parameterDictionary
          ).0
    }
    
    if let headers = query.headers {
      for (headerField, headerValue) in headers {
        mutableRequest.setValue(headerValue, forHTTPHeaderField: headerField)
      }
    }
    
    /// This works because mutableRequest is a class.
    query.service.authorizeRequest(mutableRequest)
    return mutableRequest
  }
}