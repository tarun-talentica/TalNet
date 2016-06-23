//
//  GoogleCalendarService.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation
import TalNet

struct GitHubAPIService:SecureNetworkService {
    
    let host: String = "api.github.com" // [TODO:] Put into a constant
    
    func refreshAccessToken(request request: NSMutableURLRequest,completionHandler:(NSMutableURLRequest,Bool)->Void) {
        completionHandler(self.authorizeRequest(request),true)
    }
    
    // Requests with this service always sends a token in the header.
    func authorizeRequest(request: NSMutableURLRequest) -> NSMutableURLRequest {
        /// Add whatever authorization header you want to add
//        request.setValue("Bearer " + "Tarun", forHTTPHeaderField: "Authorization")
        return request
    }
}