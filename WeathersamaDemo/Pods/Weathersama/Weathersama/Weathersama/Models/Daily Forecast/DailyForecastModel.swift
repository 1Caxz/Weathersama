//
//  DailyForeCastModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

public class DailyForecastModel {
    
    private let TAG = "DailyForecastModel"
    
    public var code: String!
    public var message: Double!
    public var cnt: Int!
    public var city: DailyForecastCity = DailyForecastCity()
    public var list: [DailyForecastListModel] = [DailyForecastListModel]()
    
    public var isDataExist = false
    
    internal func parseJSON(jsonSerialized: AnyObject) {
        if let code = jsonSerialized["cod"] as? String {
            self.code = code
        } else {
            print("\(TAG) error : JSON parse id not found")
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
            self.list = DailyForecastListModel().parseJSON(jsonArray: list)
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
            
            if let population = city["population"] as? Double {
                self.city.population = population
            } else {
                print("\(TAG) error : JSON parse population not found")
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
            print("\(TAG) error : JSON parse message not found")
        }
    }
}

public class DailyForecastCity {
    public var id: Int!
    public var name: String!
    public var coordinate: DailyForecastCityCoordinate = DailyForecastCityCoordinate()
    public var country: String!
    public var population: Double!
}

public class DailyForecastCityCoordinate {
    public var longitude: Double!
    public var latitude: Double!
}
