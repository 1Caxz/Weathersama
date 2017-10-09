//
//  URLAddressManager.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/5/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import MapKit



public enum TEMPERATURE_TYPES: String {
    case Kelvin = ""
    case Celcius = "&units=metric"
    case Fahrenheit = "&units=imperial"
}

public enum LANGUAGES: String {
    case Ukrainian = "&lang=uk"
    case Italian = "&lang=it"
    case German = "&lang=de"
    case Portuguese = "&lang=pt"
    case English = "&lang=en"
    case Romanian = "&lang=ro"
    case Russian = "&lang=ru"
    case ChineseSimplified = "&lang=zh_cn"
    case Spanish = "&lang=es"
    case French = "&lang=fr"
    case Bulgarian = "&lang=bg"
    case Polish = "&lang=pl"
    case Turkish = "&lang=tr"
    case Catalan = "&lang=ca"
    case Croatian = "&lang=hr"
    case Finnish = "&lang=fi"
    case Dutch = "&lang=nl"
    case Swedish = "&lang=sv"
    case ChineseTraditional = "zh_tw"
}

public enum DATA_RESPONSE: String {
    case JSON = ""
    case XML = "&mode=xml"
}

public enum REQUEST_TYPE: String {
    case Weather = "weather"
    case Forecast = "forecast"
    case dailyForecast = "forecast/daily"
}

class URLAddressManager {
    
    fileprivate let TAG = "URLAddressManager"
    fileprivate var APPID = ""
    fileprivate var TEMPERATURE: String = "&units=metric"
    fileprivate var LANGUAGE: String = ""
    fileprivate var DATA_RESPONSE: String = ""
    fileprivate let BASE_URL_API = "http://api.openweathermap.org/data/2.5/"
    
    init(appId: String, temperature: TEMPERATURE_TYPES?, language: LANGUAGES?, dataResponse: DATA_RESPONSE?) {
        self.APPID = appId
        if temperature != nil {
            self.TEMPERATURE = (temperature?.rawValue)!
        }
        if language != nil {
            self.LANGUAGE = (language?.rawValue)!
        }
        if dataResponse != nil {
            self.DATA_RESPONSE = (dataResponse?.rawValue)!
        }
    }
    
    internal func getCWCoordURL(coordinate: CLLocationCoordinate2D, requestType: REQUEST_TYPE) -> String {
        if requestType == .dailyForecast {
            return "http://samples.openweathermap.org/data/2.5/forecast/daily?id=524901&appid=b1b15e88fa797225412429c1c50c122a1"
        } else {
            return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
        }
    }
    
    internal func getCWCityNameURL(cityName: String, countryCode: String?, requestType: REQUEST_TYPE) -> String {
        if countryCode == nil {
            return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?q=\(cityName)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
        } else {
            return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?q=\(cityName),\(countryCode)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
        }
    }
    
    internal func getUVIndexURL(coordinate: CLLocationCoordinate2D) -> String {
        return "http://api.openweathermap.org/v3/uvi/\(Int(coordinate.latitude)),\(Int(coordinate.longitude))/current.json?appid=\(self.APPID)"
    }
    
    internal func getCWCityIdURL(cityId: Int, requestType: REQUEST_TYPE) -> String {
        return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?id=\(cityId)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
    }
    
    internal func getCWZipCodeURL(zipCode: Int, countryCode: String?, requestType: REQUEST_TYPE) -> String {
        if countryCode == nil {
            return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?zip=\(zipCode)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
        } else {
            return "http://api.openweathermap.org/data/2.5/\(requestType.rawValue)?zip=\(zipCode),\(countryCode)\(TEMPERATURE)\(DATA_RESPONSE)\(LANGUAGE)&appid=\(self.APPID)"
        }
    }
}
