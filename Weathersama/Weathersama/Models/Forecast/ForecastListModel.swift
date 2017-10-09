//
//  ForecastListModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

public class ForecastListModel {
    private let TAG = "ForecastListModel"
    
    public var cityId: Int!
    public var cityName: String!
    public var base: String!
    public var code: Int!
    public var visibility: Int!
    public var dt: Int!
    public var dtTxt: String!
    public var weather: [ForecastListWeather] = [ForecastListWeather]()
    public var main: ForecastListMain = ForecastListMain()
    public var wind: ForecastListWind = ForecastListWind()
    public var clouds: ForecastListClouds = ForecastListClouds()
    public var rain: ForecastListRain = ForecastListRain()
    public var snow: ForecastListSnow = ForecastListSnow()
    public var sys: ForecastListSys = ForecastListSys()
    
    
    internal func parseJSON(jsonArray: [[String: AnyObject]]) -> [ForecastListModel] {
        var forecastLists: [ForecastListModel] = [ForecastListModel]()
        for jsonSerialized in jsonArray {
            let forecastList: ForecastListModel = ForecastListModel()
            if let cityId = jsonSerialized["id"] as? Int {
                forecastList.cityId = cityId
            } else {
                print("\(TAG) error : JSON parsing id not found")
            }
            
            if let cityName = jsonSerialized["name"] as? String {
                forecastList.cityName = cityName
            } else {
                print("\(TAG) error : JSON parsing name not found")
            }
            
            if let base = jsonSerialized["base"] as? String {
                forecastList.base = base
            } else {
                print("\(TAG) error : JSON parsing base not found")
            }
            
            if let code = jsonSerialized["cod"] as? Int {
                forecastList.code = code
            } else {
                print("\(TAG) error : JSON parsing cod not found")
            }
            
            if let visibility = jsonSerialized["visibility"] as? Int {
                forecastList.visibility = visibility
            } else {
                print("\(TAG) error : JSON parsing visibility not found")
            }
            
            if let dt = jsonSerialized["dt"] as? Int {
                forecastList.dt = dt
            } else {
                print("\(TAG) error : JSON parsing dt not found")
            }
            
            if let dtTxt = jsonSerialized["dt_txt"] as? String {
                forecastList.dtTxt = dtTxt
            } else {
                print("\(TAG) error : JSON parsing dt_txt not found")
            }
            
            if let weathers = jsonSerialized["weather"] as? [[String: AnyObject]] {
                for weather in weathers {
                    let weatherClass = ForecastListWeather()
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
                    forecastList.weather.append(weatherClass)
                }
            } else {
                print("\(TAG) error : JSON parsing weather not found")
            }
            
            if let main = jsonSerialized["main"] as? [String: AnyObject] {
                if let temperature = main["temp"] as? Double {
                    forecastList.main.temperature = temperature
                } else {
                    print("\(TAG) error : JSON parsing temp not found")
                }
                
                if let pressure = main["pressure"] as? Int {
                    forecastList.main.pressure = pressure
                } else {
                    print("\(TAG) error : JSON parsing pressure not found")
                }
                
                if let humidity = main["humidity"] as? Int {
                    forecastList.main.humidity = humidity
                } else {
                    print("\(TAG) error : JSON parsing humidity not found")
                }
                
                if let temperatureMin = main["temp_min"] as? Double {
                    forecastList.main.temperatureMin = temperatureMin
                } else {
                    print("\(TAG) error : JSON parsing temp_min not found")
                }
                
                if let temperatureMax = main["temp_max"] as? Double {
                    forecastList.main.temperatureMax = temperatureMax
                } else {
                    print("\(TAG) error : JSON parsing temp_max not found")
                }
                
                if let seaLevel = main["sea_level"] as? Double {
                    forecastList.main.seaLevel = seaLevel
                } else {
                    print("\(TAG) error : JSON parsing sea_level not found")
                }
                
                if let groundLevel = main["grnd_level"] as? Double {
                    forecastList.main.groundLevel = groundLevel
                } else {
                    print("\(TAG) error : JSON parsing grnd_level not found")
                }
                
                if let tempKf = main["temp_kf"] as? Double {
                    forecastList.main.tempKf = tempKf
                } else {
                    print("\(TAG) error : JSON parsing temp_kf not found")
                }
            } else {
                print("\(TAG) error : JSON parsing main not found")
            }
            
            if let wind = jsonSerialized["wind"] as? [String: AnyObject] {
                if let speed = wind["speed"] as? Double {
                    forecastList.wind.speed = speed
                } else {
                    print("\(TAG) error : JSON parsing speed not found")
                }
                
                if let deg = wind["deg"] as? Int {
                    forecastList.wind.deg = deg
                } else {
                    print("\(TAG) error : JSON parsing deg not found")
                }
            } else {
                print("\(TAG) error : JSON parsing wind not found")
            }
            
            if let clouds = jsonSerialized["clouds"] as? [String: AnyObject] {
                if let all = clouds["all"] as? Int {
                    forecastList.clouds.all = all
                } else {
                    print("\(TAG) error : JSON parsing all not found")
                }
            } else {
                print("\(TAG) error : JSON parsing clouds not found")
            }
            
            if let rain = jsonSerialized["rain"] as? [String: AnyObject] {
                if let threeHours = rain["3h"] as? Double {
                    forecastList.rain.threeHours = threeHours
                } else {
                    print("\(TAG) error : JSON parsing 3h not found")
                }
            } else {
                print("\(TAG) error : JSON parsing rain not found")
            }
            
            if let snow = jsonSerialized["snow"] as? [String: AnyObject] {
                if let threeHours = snow["3h"] as? Double {
                    forecastList.snow.threeHours = threeHours
                } else {
                    print("\(TAG) error : JSON parsing 3h not found")
                }
            } else {
                print("\(TAG) error : JSON parsing snow not found")
            }
            
            if let sys = jsonSerialized["sys"] as? [String: AnyObject] {
                if let pod = sys["pod"] as? String {
                    forecastList.sys.pod = pod
                } else {
                    print("\(TAG) error : JSON parsing pod not found")
                }
            } else {
                print("\(TAG) error : JSON parsing sys not found")
            }
            forecastLists.append(forecastList)
        }
        return forecastLists
    }
}

public class ForecastListWeather {
    public var id: Int!
    public var main: String!
    public var description: String!
    public var icon: String!
}

public class ForecastListMain {
    public var temperature: Double!
    public var pressure: Int!
    public var humidity: Int!
    public var temperatureMin: Double!
    public var temperatureMax: Double!
    public var seaLevel: Double!
    public var groundLevel: Double!
    public var tempKf: Double!
}

public class ForecastListWind {
    public var speed: Double!
    public var deg: Int!
}

public class ForecastListClouds {
    public var all: Int!
}

public class ForecastListRain {
    public var threeHours: Double!
}

public class ForecastListSnow {
    public var threeHours: Double!
}

public class ForecastListSys {
    public var pod: String!
}
