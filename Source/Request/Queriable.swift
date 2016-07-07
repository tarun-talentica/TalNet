//
//  Query.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation

// HTTP methods
public enum Method: String {
    case GET,POST,PUT,DELETE
}

public protocol Queriable {
    var method: Method { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var encoding:Encoding {get }
    var headers:[String:String]? {get}
    
    // This builds the URLString from Scheme + Host
    var service: NetworkService { get }
}

public extension Queriable {
    var parameters: Parameters? {
        return nil
    }
    
    var encoding:Encoding {
        return .URL
    }
    
    var headers:[String:String]? {
        return nil
    }
}

public protocol GetQueriable: Queriable {}

public extension GetQueriable {
    var method: Method {
        return .GET
    }
}

public protocol PostQueriable: Queriable {}

public extension PostQueriable {
    var method: Method {
        return .POST
    }
}

public protocol TokenRefreshingQueriable:Queriable {}

public extension TokenRefreshingQueriable {
    func refreshAccessToken(request request: NSMutableURLRequest,completionHandler:(NSMutableURLRequest,Bool)->Void) {
        self.service.refreshAccessToken(request: request, completionHandler: completionHandler)
    }
}