//
//  WeathersamaTests.swift
//  WeathersamaTests
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import XCTest
@testable import Weathersama

class WeathersamaTests: XCTestCase {
    
    var weather: Weathersama?
    
    override func setUp() {
        super.setUp()
        weather = Weathersama(appId: "3abfe55d761d6416227002eff195bd47", temperature: .Celcius, language: .English, dataResponse: .JSON)
        weather?.weatherByCityName(cityName: "Tebet", countryCode: nil, requestType: .Weather, completion: { (isSuccess, result) -> ()? in
            print(result)
        })
    }
    
    override func tearDown() {
        weather = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
