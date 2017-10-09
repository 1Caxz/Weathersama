//
//  WeatherModel.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/5/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    internal func addDataWeather(cityId: Int, cityName: String, longitude: Double, latitude: Double, zipCode: Int) {
        if #available(iOS 10.0, *) {
            let weather = Weather(context: CoreDataStack.managedObjectContext)
            weather.cityId = Int32(cityId)
            weather.cityName = cityName
            weather.longitude = longitude
            weather.latitude = latitude
            weather.zipCode = Int32(zipCode)
        } else {
            let entityDesc = NSEntityDescription.entity(forEntityName: "Weather", in: CoreDataStack.managedObjectContext)
            let weather = Weather(entity: entityDesc!, insertInto: CoreDataStack.managedObjectContext)
            weather.cityId = Int32(cityId)
            weather.cityName = cityName
            weather.longitude = longitude
            weather.latitude = latitude
            weather.zipCode = Int32(zipCode)
        }
        CoreDataStack.saveContext()
    }
    
    internal func getAllDataWeather() -> [WeatherDataModel] {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        var weatherModels = [WeatherDataModel]()
        do {
            let fetchedResults = try CoreDataStack.managedObjectContext.fetch(fetchRequest)
            for item in fetchedResults {
                weatherModels.append(WeatherDataModel(cityId: item.value(forKey: "cityId") as! Int, cityName: item.value(forKey: "cityName") as! String, longitude: item.value(forKey: "longitude") as! Double, latitude: item.value(forKey: "latitude") as! Double, zipCode: item.value(forKey: "zipCode") as! Int))
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return weatherModels
    }
    
    internal func getSingleDataWeather(index: Int) -> WeatherDataModel {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        let weatherModel = WeatherDataModel()
        do {
            let fetchedResults = try CoreDataStack.managedObjectContext.fetch(fetchRequest)
            if fetchedResults.indices.contains(index) {
                let item = fetchedResults[index]
                weatherModel.setCityId(cityId: item.value(forKey: "cityId") as! Int)
                weatherModel.setCityName(cityName: item.value(forKey: "cityName") as! String)
                weatherModel.setLongitude(longitude: item.value(forKey: "longitude") as! Double)
                weatherModel.setLatitude(latitude: item.value(forKey: "latitude") as! Double)
                weatherModel.setZipCode(zipCode: item.value(forKey: "zipCode") as! Int)
            } else {
                
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return weatherModel
    }
    
    internal func deleteData(index: Int) {
        let fetchRequest = NSFetchRequest<Weather>(entityName: "Weather")
        do {
            let fetchedResults = try CoreDataStack.managedObjectContext.fetch(fetchRequest)
            if fetchedResults.indices.contains(index) {
                let item = fetchedResults[index]
                CoreDataStack.managedObjectContext.delete(item)
                CoreDataStack.saveContext()
            } else {
                
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
}
