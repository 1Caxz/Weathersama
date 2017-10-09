//
//  AssetManager.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

class AssetManager {
    fileprivate let TAG = "AssetManager"
    
    enum WEATHER_VIDEO: String {
        case CLEAR_DAY = "clear_day"
        case CLEAR_NIGHT = "clear_night"
        case CLOUDY_DAY = "cloudy_day"
        case FOG_DAY = "fog_day"
        case FOG_NIGHT = "fog_night"
        case HOT = "hot"
        case PARTLY_CLOUD_DAY = "partly_cloud_day"
        case PARTLY_CLOUD_NIGHT = "partly_cloud_night"
        case PARTLY_SUNNY = "partly_sunny"
        case RAIN_DAY = "rain_day"
        case RAIN_NIGHT = "rain_night"
        case SNOW_DAY = "snow_day"
        case SNOW_NIGHT = "snow_night"
        case THUNDERSTORM_DAY = "thunderstorm_day"
        case THUNDERSTORM_NIGHT = "thunderstorm_night"
        case WINDY_DAY = "windy_day"
        case WINDY_NIGHT = "windy_night"
    }
    
    internal func getLocalURL(videoType: AssetManager.WEATHER_VIDEO) -> URL {
        return Bundle.main.url(forResource: videoType.rawValue, withExtension: "mp4")!
    }
    
    internal func getLocalDirectory(videoType: AssetManager.WEATHER_VIDEO) -> String {
        return Bundle.main.path(forResource: videoType.rawValue, ofType: "mp4")!
    }
    
    internal func getWeatherCondition(weather: String, hour: Int) -> WEATHER_VIDEO {
        if weather.contains("rain") {
            if hour >= 18 || hour <= 5 {
                return .RAIN_NIGHT
            } else {
                return .RAIN_DAY
            }
        } else if weather.contains("snow") {
            if hour >= 18 || hour <= 5 {
                return .SNOW_NIGHT
            } else {
                return .SNOW_DAY
            }
        } else if weather.contains("clear") {
            if hour >= 18 || hour <= 5 {
                return .CLEAR_NIGHT
            } else {
                return .CLEAR_DAY
            }
        } else if weather.contains("thunderstorm") {
            if hour >= 18 || hour <= 5 {
                return .THUNDERSTORM_NIGHT
            } else {
                return .THUNDERSTORM_DAY
            }
        } else if weather.contains("mist") {
            if hour >= 18 || hour <= 5 {
                return .WINDY_NIGHT
            } else {
                return .WINDY_DAY
            }
        } else {
            return .CLEAR_DAY
        }
    }
}
