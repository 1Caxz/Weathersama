//
//  DailyForecastListModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

public class DailyForecastListModel {
    
    private let TAG = "DailyForecastListModel"
    
    public var dt: Int!
    public var pressure: Double!
    public var humidity: Int!
    public var speed: Double!
    public var deg: Int!
    public var clouds: Int!
    public var rain: Double!
    public var snow: Double!
    public var weather: [DailyForecastListWeather] = [DailyForecastListWeather]()
    public var temperature: DailyForecastListTemperature = DailyForecastListTemperature()
    
    
    internal func parseJSON(jsonArray: [[String: AnyObject]]) -> [DailyForecastListModel] {
        var dailyForecastLists: [DailyForecastListModel] = [DailyForecastListModel]()
        for jsonSerialized in jsonArray {
            
            let dailyForecastList: DailyForecastListModel = DailyForecastListModel()
            
            if let dt = jsonSerialized["dt"] as? Int {
                dailyForecastList.dt = dt
            } else {
                print("\(TAG) error : JSON parsing dt not found")
            }
            
            if let pressure = jsonSerialized["pressure"] as? Double {
                dailyForecastList.pressure = pressure
            } else {
                print("\(TAG) error : JSON parsing pressure not found")
            }
            
            if let humidity = jsonSerialized["humidity"] as? Int {
                dailyForecastList.humidity = humidity
            } else {
                print("\(TAG) error : JSON parsing humidity not found")
            }
            
            if let speed = jsonSerialized["speed"] as? Double {
                dailyForecastList.speed = speed
            } else {
                print("\(TAG) error : JSON parsing speed not found")
            }
            
            if let deg = jsonSerialized["deg"] as? Int {
                dailyForecastList.deg = deg
            } else {
                print("\(TAG) error : JSON parsing deg not found")
            }
            
            if let clouds = jsonSerialized["clouds"] as? Int {
                dailyForecastList.clouds = clouds
            } else {
                print("\(TAG) error : JSON parsing clouds not found")
            }
            
            if let rain = jsonSerialized["rain"] as? Double {
                dailyForecastList.rain = rain
            } else {
                print("\(TAG) error : JSON parsing rain not found")
            }
            
            if let snow = jsonSerialized["snow"] as? Double {
                dailyForecastList.snow = snow
            } else {
                print("\(TAG) error : JSON parsing snow not found")
            }
            
            if let weathers = jsonSerialized["weather"] as? [[String: AnyObject]] {
                for weather in weathers {
                    let weatherClass = DailyForecastListWeather()
                    if let id = weather["id"] as? Int {
                        weatherClass.id = id
                    } else {
                        print("\(TAG) error : JSON parsing id not found")
                    }
                    
                    if let main = weather["main"] as? String {
                        weatherClass.main = main
                    } else {
                        print("\(TAG) error : JSON parsing main not found")
                    }
                    
                    if let description = weather["description"] as? String {
                        weatherClass.description = description
                    } else {
                        print("\(TAG) error : JSON parsing description not found")
                    }
                    
                    if let icon = weather["icon"] as? String {
                        weatherClass.icon = icon
                    } else {
                        print("\(TAG) error : JSON parsing icon not found")
                    }
                    dailyForecastList.weather.append(weatherClass)
                }
            } else {
                print("\(TAG) error : JSON parsing weather not found")
            }
            
            if let temperature = jsonSerialized["temp"] as? [String: AnyObject] {
                if let day = temperature["day"] as? Double {
                    dailyForecastList.temperature.day = day
                } else {
                    print("\(TAG) error : JSON parsing day not found")
                }
                
                if let min = temperature["min"] as? Double {
                    dailyForecastList.temperature.min = min
                } else {
                    print("\(TAG) error : JSON parsing min not found")
                }
                
                if let max = temperature["max"] as? Double {
                    dailyForecastList.temperature.max = max
                } else {
                    print("\(TAG) error : JSON parsing max not found")
                }
                
                if let night = temperature["night"] as? Double {
                    dailyForecastList.temperature.night = night
                } else {
                    print("\(TAG) error : JSON parsing night not found")
                }
                
                if let evening = temperature["eve"] as? Double {
                    dailyForecastList.temperature.evening = evening
                } else {
                    print("\(TAG) error : JSON parsing eve not found")
                }
                
                if let morning = temperature["morn"] as? Double {
                    dailyForecastList.temperature.morning = morning
                } else {
                    print("\(TAG) error : JSON parsing morn not found")
                }
            } else {
                print("\(TAG) error : JSON parsing temp not found")
            }
            
            dailyForecastLists.append(dailyForecastList)
        }
        return dailyForecastLists
    }
}

public class DailyForecastListWeather {
    public var id: Int!
    public var main: String!
    public var description: String!
    public var icon: String!
}

public class DailyForecastListTemperature {
    public var day: Double!
    public var min: Double!
    public var max: Double!
    public var night: Double!
    public var evening: Double!
    public var morning: Double!
}
