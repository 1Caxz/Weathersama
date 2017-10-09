//
//  Weathersama.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import MapKit

public protocol WeathersamaDelegete {
    func didStartRequestResponder()
    func didEndRequestResponder(result: Bool, description: String, requestType: REQUEST_TYPE)
}

public class Weathersama {
    fileprivate let LOG: String = "Weathersama"
    fileprivate let utilitiesManager = UtilitiesManager()
    fileprivate var urlAddressManager: URLAddressManager!
    
    public var delegete: WeathersamaDelegete!
    
    public init(appId: String, temperature: TEMPERATURE_TYPES?, language: LANGUAGES?, dataResponse: DATA_RESPONSE?) {
        self.urlAddressManager = URLAddressManager(appId: appId, temperature: temperature, language: language, dataResponse: dataResponse)
    }
    
    public func weatherByCoordinate(coordinate: CLLocationCoordinate2D, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject) -> ()?) {
        startRequest(url: urlAddressManager.getCWCoordURL(coordinate: coordinate, requestType: requestType), requestType: requestType, completion: completion)
    }
    
    public func weatherByCityName(cityName: String, countryCode: String?, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject) -> ()?) {
        startRequest(url: urlAddressManager.getCWCityNameURL(cityName: cityName, countryCode: countryCode, requestType: requestType), requestType: requestType, completion: completion)
    }
    
    public func weatherByCityId(cityId: Int, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject) -> ()?) {
        startRequest(url: urlAddressManager.getCWCityIdURL(cityId: cityId, requestType: requestType), requestType: requestType, completion: completion)
    }
    
    public func weatherByZipCode(zipCode: Int, countryCode: String?, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject) -> ()?) {
        startRequest(url: urlAddressManager.getCWZipCodeURL(zipCode: zipCode, countryCode: countryCode, requestType: requestType), requestType: requestType, completion: completion)
    }
    
    public func getUVIndex(coordinate: CLLocationCoordinate2D, completion: @escaping(Bool, String, Double) -> ()) {
        utilitiesManager.requestSpecificAPI(url: urlAddressManager.getUVIndexURL(coordinate: coordinate)) { (isSuccess, result) in
            if isSuccess {
                if let json = result as? [String: AnyObject] {
                    let resultVaule = json["data"] as! Double
                    completion(true, "Success", resultVaule)
                }
            } else {
                completion(false, result as! String, 0)
            }
        }
    }
    
    private func startRequest(url: String, requestType: REQUEST_TYPE, completion: @escaping(Bool, String, AnyObject) -> ()?) {
        if delegete != nil {
            delegete.didStartRequestResponder()
        }
        utilitiesManager.requestAPI(url: url, requestType: requestType) { (isSuccess, resultString, classModel) in
            if self.delegete != nil {
                self.delegete.didEndRequestResponder(result: isSuccess, description: resultString, requestType: requestType)
            }
            completion(isSuccess, resultString, classModel!)
        }
    }
}
