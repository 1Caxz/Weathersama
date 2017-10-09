//
//  WeatherPresenter.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/8/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import Weathersama
import MapKit

class WeatherPresenter {
    
    fileprivate var viewController: WeatherViewController!
    fileprivate var weatherModel: WeatherModel!
    fileprivate var forecastModel: ForecastModel!
    fileprivate var dailyForecastModel: DailyForecastModel!
    fileprivate var weatherSama: Weathersama!
    fileprivate var uvIndex: Double = 0
    
    internal var isDataLoaded = false
    
    init(viewController: WeatherViewController) {
        self.viewController = viewController
        self.weatherSama = Weathersama(appId: appId, temperature: .Celcius, language: nil, dataResponse: .JSON)
    }
    
    init(viewController: WeatherViewController, weatherModel: WeatherModel, forecastModel: ForecastModel, dailyForecastModel: DailyForecastModel) {
        self.viewController = viewController
        self.weatherModel = weatherModel
        self.forecastModel = forecastModel
        self.dailyForecastModel = dailyForecastModel
    }
    
    internal func setUVIndex(uvIndex: Double) {
        self.uvIndex = uvIndex
    }
    
    internal func getUVIndex() -> Double {
        return uvIndex
    }
    
    internal func setWeatherModel(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
    internal func getWeatherModel() -> WeatherModel {
        return self.weatherModel
    }
    
    internal func setForecastModel(forecastModel: ForecastModel) {
        self.forecastModel = forecastModel
    }
    
    internal func getForecastModel() -> ForecastModel{
        return self.forecastModel
    }
    
    internal func setDailyForecastModel(dailyForecastModel: DailyForecastModel) {
        self.dailyForecastModel = dailyForecastModel
    }
    
    internal func getDailyForecastModel() -> DailyForecastModel {
        return self.dailyForecastModel
    }
    
    internal func generateWeatherData() {
        if weatherModel != nil {
            viewController.cityName.text = weatherModel.cityName
            viewController.temperature.text = "\(Int(weatherModel.main.temperature!))\u{00B0}"
            viewController.currentDay.text = "\(appUtilities.getDayName(timeInterval: weatherModel.dt)) TODAY"
            viewController.tempMax.text = "\(Int(weatherModel.main.temperatureMax!))\u{00B0}"
            viewController.tempMin.text = "\(Int(weatherModel.main.temperatureMin!))\u{00B0}"
            viewController.weatherType.text = weatherModel.weather[0].main
        } else {
            print("Weather model is nil.")
        }
    }
    
    internal func requestWeatherData(coord: CLLocationCoordinate2D, completion: @escaping() -> ()) {
        weatherSama.weatherByCoordinate(coordinate: coord, requestType: .Weather, completion: { (isSuccess, result, classModel) -> () in
            if isSuccess {
                let model = classModel as! WeatherModel
                if !model.isDataExist {
                    appUtilities.showStandardDialogOKEvent(viewController: self.viewController, title: "Warning", message: "Sorry some feature may be not work prefectly, Since 9 October 2015 openweathermap.org give limitation access. Please wait about 10 minute to access again.", event: {
                        
                    })
                }
                self.setWeatherModel(weatherModel: model)
            } else {
                print("Cannot get data for Weather!")
            }
            self.weatherSama.weatherByCoordinate(coordinate: coord, requestType: .Forecast, completion: { (isSuccess, result, classModel) -> () in
                if isSuccess {
                    let model = classModel as! ForecastModel
                    if !model.isDataExist {
                        appUtilities.showStandardDialogOKEvent(viewController: self.viewController, title: "Warning", message: "Sorry some feature may be not work prefectly, Since 9 October 2015 openweathermap.org give limitation access. Please wait about 10 minute to access again.", event: {
                            
                        })
                    }
                    self.setForecastModel(forecastModel: model)
                } else {
                    print("Cannot get data for Forecast!")
                }
                self.weatherSama.weatherByCoordinate(coordinate: coord, requestType: .dailyForecast, completion: { (isSuccess, result, classModel) -> () in
                    if isSuccess {
                        let model = classModel as! DailyForecastModel
                        if !model.isDataExist {
                            appUtilities.showStandardDialogOKEvent(viewController: self.viewController, title: "Warning", message: "Sorry some feature may be not work prefectly, Since 9 October 2015 openweathermap.org give limitation access. Please wait about 10 minute to access again.", event: {
                                
                            })
                        }
                        self.setDailyForecastModel(dailyForecastModel: model)
                    } else {
                        print("Cannot get data for Daily Forecast!")
                    }
                    completion()
                    self.isDataLoaded = true
                    self.weatherSama.getUVIndex(coordinate: coord, completion: { (isSuccess, description, value) in
                        if isSuccess {
                            self.setUVIndex(uvIndex: value)
                        } else {
                            print("Cannot get data for UVIndex!")
                        }
                    })
                })
            })
        })
    }
    
    internal func setDataForecastScrollCell(forecastScrollCell: ForecastScrollCell,forecastModel: ForecastModel, weatherModel: WeatherModel) {
        if !forecastModel.isDataExist || !weatherModel.isDataExist {
            return
        }
        var dynamicX = 16
        var isSunsetAdded = false
        var isSunriseAdded = false
        forecastScrollCell.addViewWeather(hour: "Now", imageURL: "http://openweathermap.org/img/w/\(forecastModel.list[0].weather[0].icon!).png", temp: "\(Int(weatherModel.main.temperature))", dynamicX: Double(dynamicX))
        dynamicX += 75
        for list in forecastModel.list {
            let hour = appUtilities.getHour(timeInterval: list.dt)
            if hour == "7" && !isSunriseAdded {
                forecastScrollCell.addViewWeather(hour: appUtilities.getTime(timeInterval: weatherModel.sys.sunrise), imageURL: "sunrise", temp: "Sunrise", dynamicX: Double(dynamicX))
                dynamicX += 75
                isSunriseAdded = true
            }
            
            if hour == "19" && !isSunsetAdded {
                forecastScrollCell.addViewWeather(hour: appUtilities.getTime(timeInterval: weatherModel.sys.sunset), imageURL: "sunset", temp: "Sunset", dynamicX: Double(dynamicX))
                dynamicX += 75
                isSunsetAdded = true
            }
            
            if !isSunsetAdded || !isSunriseAdded {
                forecastScrollCell.addViewWeather(hour: hour, imageURL: "http://openweathermap.org/img/w/\(list.weather[0].icon!).png", temp: "\(Int(list.main.temperature!))\u{00B0}", dynamicX: Double(dynamicX))
                dynamicX += 50
            }
        }
        forecastScrollCell.scrollView.showsHorizontalScrollIndicator = false
        forecastScrollCell.scrollView.contentSize.width = CGFloat(dynamicX + 16)
    }
    
    internal func setDataDailyForecast(dailyForecastCell: DailyForecastCell,dailyForecastModel: DailyForecastModel) {
        if !dailyForecastModel.isDataExist {
            return
        }
        dailyForecastCell.day1.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[0].dt)
        dailyForecastCell.day2.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[1].dt)
        dailyForecastCell.day3.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[2].dt)
        dailyForecastCell.day4.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[3].dt)
        dailyForecastCell.day5.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[4].dt)
        dailyForecastCell.day6.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[5].dt)
        dailyForecastCell.day7.text = appUtilities.getDayName(timeInterval: dailyForecastModel.list[6].dt)
        
        dailyForecastCell.icon1.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[0].weather[0].icon!).png")
        dailyForecastCell.icon2.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[1].weather[0].icon!).png")
        dailyForecastCell.icon3.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[2].weather[0].icon!).png")
        dailyForecastCell.icon4.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[3].weather[0].icon!).png")
        dailyForecastCell.icon5.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[4].weather[0].icon!).png")
        dailyForecastCell.icon6.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[5].weather[0].icon!).png")
        dailyForecastCell.icon7.imageFrom(link: "http://openweathermap.org/img/w/\(dailyForecastModel.list[6].weather[0].icon!).png")
        
        dailyForecastCell.tempMax1.text = "\(Int(dailyForecastModel.list[0].temperature.min!))"
        dailyForecastCell.tempMax2.text = "\(Int(dailyForecastModel.list[1].temperature.min!))"
        dailyForecastCell.tempMax3.text = "\(Int(dailyForecastModel.list[2].temperature.min!))"
        dailyForecastCell.tempMax4.text = "\(Int(dailyForecastModel.list[3].temperature.min!))"
        dailyForecastCell.tempMax5.text = "\(Int(dailyForecastModel.list[4].temperature.min!))"
        dailyForecastCell.tempMax6.text = "\(Int(dailyForecastModel.list[5].temperature.min!))"
        dailyForecastCell.tempMax7.text = "\(Int(dailyForecastModel.list[6].temperature.min!))"
        
        dailyForecastCell.tempMin1.text = "\(Int(dailyForecastModel.list[0].temperature.min!))"
        dailyForecastCell.tempMin2.text = "\(Int(dailyForecastModel.list[1].temperature.min!))"
        dailyForecastCell.tempMin3.text = "\(Int(dailyForecastModel.list[2].temperature.min!))"
        dailyForecastCell.tempMin4.text = "\(Int(dailyForecastModel.list[3].temperature.min!))"
        dailyForecastCell.tempMin5.text = "\(Int(dailyForecastModel.list[4].temperature.min!))"
        dailyForecastCell.tempMin6.text = "\(Int(dailyForecastModel.list[5].temperature.min!))"
        dailyForecastCell.tempMin7.text = "\(Int(dailyForecastModel.list[6].temperature.min!))"
    }
    
    internal func setDataWeatherMessageCell(weatherMessageCell: WeatherMessageCell,weatherModel: WeatherModel) {
        weatherMessageCell.lblMessage.text = "Today : \(appUtilities.getDayName(timeInterval: weatherModel.dt ?? 0)) today. It's currently \(Int(weatherModel.main.temperature ?? 0))\u{00B0}, the high will be \(Int(weatherModel.main.temperatureMax ?? 0))\u{00B0}."
    }
    
    internal func setDataWeatherDetailCell(weatherDetailCell: WeatherDetailCell, leftTitle: String, leftValue: String, rightTitle: String, rightValue: String) {
        weatherDetailCell.leftTitle.text = leftTitle
        weatherDetailCell.leftValue.text = leftValue
        weatherDetailCell.rightTitle.text = rightTitle
        weatherDetailCell.rightValue.text = rightValue
    }
}
