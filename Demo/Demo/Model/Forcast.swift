//
//  ForcastResponse.swift
//  TLCNetworking_Protocol
//
//  Created by Tarun Sharma on 07/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import Foundation
import TalNet
import ObjectMapper

struct Forecast: ObjectMappable {
    var day: String?
    var temperature: Int?
    var conditions: String?
    
    init?(_ map: ObjectMap){
        
    }
    
    mutating func mapObject(from map: ObjectMap) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}

struct Weather: ObjectMappable {
    var location: String?
    var threeDayForecast: [Forecast]?
    
    init?(_ map: ObjectMap){
        
    }
    
    mutating func mapObject(from map: ObjectMap) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}