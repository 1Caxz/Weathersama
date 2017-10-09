//
//  WeatherModel.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/5/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    fileprivate var cityId: Int = 0
    fileprivate var cityName: String = ""
    fileprivate var longitude: Double = 0
    fileprivate var latitude: Double = 0
    fileprivate var zipCode: Int = 0
    
    init() {
        
    }
    
    init(cityId: Int, cityName: String, longitude: Double, latitude: Double, zipCode: Int) {
        self.cityId = cityId
        self.cityName = cityName
        self.longitude = longitude
        self.latitude = latitude
        self.zipCode = zipCode
    }
    
    internal func setCityId(cityId: Int) {
        self.cityId = cityId
    }
    
    internal func getCityId() -> Int {
        return cityId
    }
    
    internal func setCityName(cityName: String) {
        self.cityName = cityName
    }
    
    internal func getCityName() -> String {
        return cityName
    }
    
    internal func setLongitude(longitude: Double) {
        self.longitude = longitude
    }
    
    internal func getLongitude() -> Double {
        return longitude
    }
    
    internal func setLatitude(latitude: Double) {
        self.latitude = latitude
    }
    
    internal func getLatitude() -> Double {
        return latitude
    }
    
    internal func setZipCode(zipCode: Int) {
        self.zipCode = zipCode
    }
    
    internal func getZipCode() -> Int {
        return zipCode
    }
}
