//
//  OpenWeatherModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//  Convert JSON to be Class Model from openweathermap.org

import Foundation

public class WeatherModel {
    
    private let TAG = "WeatherModel"
    
    public var cityId: Int!
    public var cityName: String!
    public var base: String!
    public var code: Int!
    public var visibility: Int!
    public var dt: Int!
    public var coordinate: WeatherCoordinate = WeatherCoordinate()
    public var weather: [WeatherWeather] = [WeatherWeather]()
    public var main: WeatherMain = WeatherMain()
    public var wind: WeatherWind = WeatherWind()
    public var clouds: WeatherClouds = WeatherClouds()
    public var rain: WeatherRain = WeatherRain()
    public var snow: WeatherSnow = WeatherSnow()
    public var sys: WeatherSys = WeatherSys()
    
    public var isDataExist = false
    
    internal func parseJSON(jsonSerialized: AnyObject) {
        if let cityId = jsonSerialized["id"] as? Int {
            self.cityId = cityId
        } else {
            print("\(TAG) error : JSON parsing id not found")
        }
        
        if let cityName = jsonSerialized["name"] as? String {
            self.cityName = cityName
        } else {
            print("\(TAG) error : JSON parsing name not found")
        }
        
        if let base = jsonSerialized["base"] as? String {
            self.base = base
        } else {
            print("\(TAG) error : JSON parsing base not found")
        }
        
        if let code = jsonSerialized["cod"] as? Int {
            self.code = code
        } else {
            print("\(TAG) error : JSON parsing cod not found")
        }
        
        if let visibility = jsonSerialized["visibility"] as? Int {
            self.visibility = visibility
        } else {
            print("\(TAG) error : JSON parsing visibility not found")
        }
        
        if let dt = jsonSerialized["dt"] as? Int {
            self.dt = dt
        } else {
            print("\(TAG) error : JSON parsing dt not found")
        }
        
        if let coordinate = jsonSerialized["coord"] as? [String: AnyObject] {
            isDataExist = true
            if let longitude = coordinate["lon"] as? Double {
                self.coordinate.longitude = longitude
            } else {
                print("\(TAG) error : JSON parsing lon not found")
            }
            
            if let latitude = coordinate["lat"] as? Double {
                self.coordinate.latitude = latitude
            } else {
                print("\(TAG) error : JSON parsing lat not found")
            }
        } else {
            print("\(TAG) error : JSON parsing coord not found")
        }
        
        if let weathers = jsonSerialized["weather"] as? [[String: AnyObject]] {
            for weather in weathers {
                let weatherClass = WeatherWeather()
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
                self.weather.append(weatherClass)
            }
        } else {
            print("\(TAG) error : JSON parsing weather not found")
        }
        
        if let main = jsonSerialized["main"] as? [String: AnyObject] {
            if let temperature = main["temp"] as? Double {
                self.main.temperature = temperature
            } else {
                print("\(TAG) error : JSON parsing temp not found")
            }
            
            if let pressure = main["pressure"] as? Int {
                self.main.pressure = pressure
            } else {
                print("\(TAG) error : JSON parsing pressure not found")
            }
            
            if let humidity = main["humidity"] as? Int {
                self.main.humidity = humidity
            } else {
                print("\(TAG) error : JSON parsing humidity not found")
            }
            
            if let temperatureMin = main["temp_min"] as? Double {
                self.main.temperatureMin = temperatureMin
            } else {
                print("\(TAG) error : JSON parsing temp_min not found")
            }
            
            if let temperatureMax = main["temp_max"] as? Double {
                self.main.temperatureMax = temperatureMax
            } else {
                print("\(TAG) error : JSON parsing temp_max not found")
            }
            
            if let seaLevel = main["sea_level"] as? Double {
                self.main.seaLevel = seaLevel
            } else {
                print("\(TAG) error : JSON parsing sea_level not found")
            }
            
            if let groundLevel = main["grnd_level"] as? Double {
                self.main.groundLevel = groundLevel
            } else {
                print("\(TAG) error : JSON parsing grnd_level not found")
            }
        } else {
            print("\(TAG) error : JSON parsing main not found")
        }
        
        if let wind = jsonSerialized["wind"] as? [String: AnyObject] {
            if let speed = wind["speed"] as? Double {
                self.wind.speed = speed
            } else {
                print("\(TAG) error : JSON parsing speed not found")
            }
            
            if let deg = wind["deg"] as? Int {
                self.wind.deg = deg
            } else {
                print("\(TAG) error : JSON parsing deg not found")
            }
        } else {
            print("\(TAG) error : JSON parsing wind not found")
        }
        
        if let clouds = jsonSerialized["clouds"] as? [String: AnyObject] {
            if let all = clouds["all"] as? Int {
                self.clouds.all = all
            } else {
                print("\(TAG) error : JSON parsing all not found")
            }
        } else {
            print("\(TAG) error : JSON parsing clouds not found")
        }
        
        if let rain = jsonSerialized["rain"] as? [String: AnyObject] {
            if let threeHours = rain["3h"] as? Double {
                self.rain.threeHours = threeHours
            } else {
                print("\(TAG) error : JSON parsing 3h not found")
            }
        } else {
            print("\(TAG) error : JSON parsing rain not found")
        }
        
        if let snow = jsonSerialized["snow"] as? [String: AnyObject] {
            if let threeHours = snow["3h"] as? Double {
                self.snow.threeHours = threeHours
            } else {
                print("\(TAG) error : JSON parsing 3h not found")
            }
        } else {
            print("\(TAG) error : JSON parsing snow not found")
        }
        
        if let sys = jsonSerialized["sys"] as? [String: AnyObject] {
            if let type = sys["type"] as? Int {
                self.sys.type = type
            } else {
                print("\(TAG) error : JSON parsing type not found")
            }
            
            if let id = sys["id"] as? Int {
                self.sys.id = id
            } else {
                print("\(TAG) error : JSON parsing id not found")
            }
            
            if let message = sys["message"] as? Double {
                self.sys.message = message
            } else {
                print("\(TAG) error : JSON parsing message not found")
            }
            
            if let country = sys["country"] as? String {
                self.sys.country = country
            } else {
                print("\(TAG) error : JSON parsing country not found")
            }
            
            if let sunrise = sys["sunrise"] as? Int {
                self.sys.sunrise = sunrise
            } else {
                print("\(TAG) error : JSON parsing sunrise not found")
            }
            
            if let sunset = sys["sunset"] as? Int {
                self.sys.sunset = sunset
            } else {
                print("\(TAG) error : JSON parsing sunset not found")
            }
        } else {
            print("\(TAG) error : JSON parsing sys not found")
        }
    }
}

public class WeatherCoordinate {
    public var longitude: Double!
    public var latitude: Double!
}

public class WeatherWeather {
    public var id: Int!
    public var main: String!
    public var description: String!
    public var icon: String!
}

public class WeatherMain {
    public var temperature: Double!
    public var pressure: Int!
    public var humidity: Int!
    public var temperatureMin: Double!
    public var temperatureMax: Double!
    public var seaLevel: Double!
    public var groundLevel: Double!
}

public class WeatherWind {
    public var speed: Double!
    public var deg: Int!
}

public class WeatherClouds {
    public var all: Int!
}

public class WeatherRain {
    public var threeHours: Double!
}

public class WeatherSnow {
    public var threeHours: Double!
}

public class WeatherSys {
    public var type: Int!
    public var id: Int!
    public var message: Double!
    public var country: String!
    public var sunrise: Int!
    public var sunset: Int!
}
