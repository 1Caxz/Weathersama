//
//  ForecastModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
public class ForecastModel {
    
    private let TAG = "ForecastModel"
    
    public var code: String!
    public var message: Double!
    public var cnt: Int!
    public var city: ForecastCity = ForecastCity()
    public var list: [ForecastListModel] = [ForecastListModel]()
    
    public var isDataExist = false
    
    internal func parseJSON(jsonSerialized: AnyObject) {
        if let code = jsonSerialized["cod"] as? String {
            self.code = code
        } else {
            print("\(TAG) error : JSON parse cod not found")
        }
        
        if let message = jsonSerialized["message"] as? Double {
            self.message = message
        } else {
            print("\(TAG) error : JSON parse message not found")
        }
        
        if let cnt = jsonSerialized["cnt"] as? Int {
            self.cnt = cnt
        } else {
            print("\(TAG) error : JSON parse cnt not found")
        }
        
        if let list = jsonSerialized["list"] as? [[String: AnyObject]] {
            self.list = ForecastListModel().parseJSON(jsonArray: list)
        } else {
            print("\(TAG) error : JSON parsing list not found")
        }
        
        if let city = jsonSerialized["city"] as? [String: AnyObject] {
            isDataExist = true
            if let id = city["id"] as? Int {
                self.city.id = id
            } else {
                print("\(TAG) error : JSON parse id not found")
            }
            
            if let name = city["name"] as? String {
                self.city.name = name
            } else {
                print("\(TAG) error : JSON parse name not found")
            }
            
            if let country = city["country"] as? String {
                self.city.country = country
            } else {
                print("\(TAG) error : JSON parse name not found")
            }
            
            if let coordinate = city["coord"] as? [String: AnyObject] {
                if let longitude = coordinate["lon"] as? Double {
                    self.city.coordinate.longitude = longitude
                } else {
                    print("\(TAG) error : JSON parse lon not found")
                }
                
                if let latitude = coordinate["lat"] as? Double {
                    self.city.coordinate.latitude = latitude
                } else {
                    print("\(TAG) error : JSON parse lat not found")
                }
            } else {
                print("\(TAG) error : JSON parse coord not found")
            }
        } else {
            print("\(TAG) error : JSON parse city not found")
        }
    }
}

public class ForecastCity {
    public var id: Int!
    public var name: String!
    public var coordinate: ForecastCityCoordinate = ForecastCityCoordinate()
    public var country: String!
}

public class ForecastCityCoordinate {
    public var longitude: Double!
    public var latitude: Double!
}
