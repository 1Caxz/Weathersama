//
//  UtilitiesManager.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class UtilitiesManager {
    
    fileprivate let TAG = "UtilitiesManager"
    
    internal func requestAPI(url: String, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject?) -> ()) {
        Alamofire.request(url).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)  {
                if requestType == .Weather {
                    let weather = WeatherModel()
                    weather.parseJSON(jsonSerialized: response.result.value as AnyObject)
                    completion(true, utf8Text, weather)
                } else if requestType == .Forecast {
                    let forecast = ForecastModel()
                    forecast.parseJSON(jsonSerialized: response.result.value as AnyObject)
                    completion(true, utf8Text, forecast)
                } else if requestType == .dailyForecast {
                    let dailyForecast = DailyForecastModel()
                    dailyForecast.parseJSON(jsonSerialized: response.result.value as AnyObject)
                    completion(true, utf8Text, dailyForecast)
                }
            } else {
                completion(false, response.error.debugDescription, nil)
            }
        }
    }
    
    internal func requestSpecificAPI(url: String, completion: @escaping(Bool, Any) -> ()) {
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                completion(true, json)
            } else {
                completion(false, response.error.debugDescription)
            }
        }
    }
    
    internal func getCoordinateFromJSON(jsonSerialized: AnyObject) -> CLLocationCoordinate2D {
        var coord = CLLocationCoordinate2D()
        if let results = jsonSerialized["results"] as? [[String: AnyObject]] {
            for result in results {
                if let geometry = result["geometry"] as? [String: AnyObject] {
                    if let location = geometry["location"] as? [String: AnyObject] {
                        let lat = location["lat"] as? Double
                        let lon = location["lng"] as? Double
                        coord.latitude = CLLocationDegrees(lat!)
                        coord.longitude = CLLocationDegrees(lon!)
                    }
                }
            }
        }
        return coord
    }
}
