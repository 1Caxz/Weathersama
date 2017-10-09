//
//  WeatherListPresenter.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/8/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import MapKit
import Weathersama

class WeatherListPresenter {
    
    fileprivate var viewController: WeatherListViewController!
    fileprivate var coord = CLLocationCoordinate2D()
    fileprivate var weatherSama: Weathersama!
    
    init(viewController: WeatherListViewController) {
        self.viewController = viewController
        self.weatherSama = Weathersama(appId: appId, temperature: .Celcius, language: nil, dataResponse: .JSON)
    }
    
    internal func setDataWeatherListCell(weatherListCell: WeatherListCell, longitude: Double, latitude: Double) {
        coord.latitude = CLLocationDegrees(latitude)
        coord.longitude = CLLocationDegrees(longitude)
        self.weatherSama.weatherByCoordinate(coordinate: coord, requestType: .Weather) { (isSuccess, result, classModel) -> () in
            let model = classModel as! WeatherModel
            weatherListCell.lblCityName.text = model.cityName
            weatherListCell.lblTime.text = appUtilities.getTime(timeInterval: model.dt)
            weatherListCell.lblTemperature.text = "\(Int(model.main.temperature) ?? 0)\u{00B0}"
            let player = appUtilities.setVideoUIView(view: weatherListCell, videoType: .SNOW_NIGHT)
            appUtilities.videoAlwaysPlay(videoPlayer: player)
        }
    }
}
