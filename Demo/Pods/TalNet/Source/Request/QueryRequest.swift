//
//  QueryRequest.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//

import Foundation

// Request structure that will have a query (defines the endpoint)
struct QueryRequest:Requestable {
    let query: Queriable
    
    init(_ query: Queriable) {
        self.query = query
    }
}