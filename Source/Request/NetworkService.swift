//
//  NetworkService.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation

public protocol NetworkService {
  var host: String { get }
  var port: Int? {get}
  var scheme: String { get }
  var serviceType: NSURLRequestNetworkServiceType { get }
  func refreshAccessToken(request request: NSMutableURLRequest,completionHandler:(NSMutableURLRequest,Bool)->Void)
  func authorizeRequest(request: NSMutableURLRequest) -> NSMutableURLRequest
}

public extension NetworkService {
  
  var port: Int? {
    return nil
  }
  
  /// Network service has network service type as default
  var serviceType: NSURLRequestNetworkServiceType {
    return .NetworkServiceTypeDefault
  }
  
  func refreshAccessToken(request request: NSMutableURLRequest,completionHandler:(NSMutableURLRequest,Bool)->Void){
    completionHandler(request,true)
  }
  
  func authorizeRequest(request: NSMutableURLRequest) -> NSMutableURLRequest {
    return request
  }
  
}
