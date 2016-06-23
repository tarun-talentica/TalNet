//
//  ViewController.swift
//  Demo
//
//  Created by Tarun Sharma on 23/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import UIKit
import TalNet

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let weatherResponse = ObjectResponse<Weather>()
    Networking.sharedManager.request(WeatherQuery())
      .response(type: weatherResponse){ response in
        print(response.result.error)
      }
      .response(type: weatherResponse) { response in
        if let weather = response.result.value {
          
          if let location = weather.location {
            print(location)
          }
          
          if let threeDayForecast = weather.threeDayForecast {
            for case let forecast in threeDayForecast {
              print(forecast.day!)
              print(forecast.temperature!)
            }
          }
        }
    }
    
    Networking.sharedManager.request(ZenQuery())
      .response(type: StringResponse()) { response in
        if let str = response.result.value {
          print(str)
        } else {
          print(response.result.error)
        }
        
    }

  }

}

