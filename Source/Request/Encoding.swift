//
//  Encoding+Alamofire.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 09/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

public enum Encoding {
    case URL,JSON
    
    public func encode(URLRequest: NSMutableURLRequest,
                       parameters: [String: AnyObject]?) -> (NSMutableURLRequest, NSError?) {
        
        guard let encodedURLRequest = VendorNetworking.sharedManager.encodeParameters(self, URLRequest: URLRequest, parameters: parameters)
            else {
                return (URLRequest, nil)
        }
        
        return encodedURLRequest
    }
}