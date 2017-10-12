//
//  WeathersamaForGoogle.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/9/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import MapKit

public class WeathersamaForGoogle {
    
    fileprivate let LOG: String = "WeathersamaForGoogle"
    fileprivate let utilitiesManager = UtilitiesManager()
    fileprivate var API_KEY = ""
    
    public init(apiKey: String) {
        self.API_KEY = apiKey
    }
    
    public func lookingForLocationBy(input: String, completion: @escaping(Bool, GoogleSearchLocationModel) -> ()) {
        utilitiesManager.requestSpecificAPI(url: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&key=\(self.API_KEY)") { (isSuccess, result) in
            let googleSearchModel = GoogleSearchLocationModel()
            if isSuccess {
                googleSearchModel.parseJSON(jsonSerialized: result as AnyObject)
                completion(true, googleSearchModel)
            } else {
                completion(false, googleSearchModel)
            }
        }
    }
    
    public func getCoordinateByPlaceId(placeId: String, completion: @escaping(Bool, CLLocationCoordinate2D) -> ()) {
        utilitiesManager.requestSpecificAPI(url: "https://maps.googleapis.com/maps/api/geocode/json?place_id=\(placeId)&key=\(self.API_KEY)") { (isSuccess, result) in
            let coord = self.utilitiesManager.getCoordinateFromJSON(jsonSerialized: result as AnyObject)
            if isSuccess {
                completion(true, coord)
            } else {
                completion(false, coord)
            }
        }
    }
    
}
