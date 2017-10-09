//
//  MainPresenter.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import Weathersama
import MapKit

class MainPresenter: NSObject, CLLocationManagerDelegate {
    
    fileprivate var viewController: MainViewController!
    fileprivate var coreDataManager: CoreDataManager!
    fileprivate var locManager: CLLocationManager!
    
    internal var coord = CLLocationCoordinate2D()
    
    init(viewController: MainViewController) {
        super.init()
        self.viewController = viewController
        self.coreDataManager = CoreDataManager()
        self.locManager = CLLocationManager()
        self.locManager.delegate = self
        self.coord = requestLocation()
    }
    
    internal func setWeatherData() {
        var viewControllers = [UIViewController]()
        let totalData = coreDataManager.getAllDataWeather().count
        let weatherController = WeatherViewController(nibName: "WeatherViewController", bundle: nil)
        weatherController.coord = self.coord
        viewControllers.append(weatherController)
        for i in 0 ..< totalData {
            let weatherData = coreDataManager.getSingleDataWeather(index: i)
            let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(weatherData.getLatitude()), longitude: CLLocationDegrees(weatherData.getLongitude()))
            let weatherController = WeatherViewController(nibName: "WeatherViewController", bundle: nil)
            weatherController.coord = coord
            viewControllers.append(weatherController)
        }
        self.viewController.addWeatherPage(viewControllers: viewControllers)
        self.viewController.reloadWeatherPage()
    }
    
    fileprivate func requestLocation() -> CLLocationCoordinate2D {
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            coord.latitude = (locManager.location?.coordinate.latitude)!
            coord.longitude = (locManager.location?.coordinate.longitude)!
        } else {
            print("Permission not active. App will give to default direction.")
            coord.latitude = CLLocationDegrees(exactly: -7.303911)!
            coord.longitude = CLLocationDegrees(exactly: 109.520138)!
        }
        return coord
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.setWeatherData()
        } else if status == .notDetermined {
            self.coord = requestLocation()
        } else {
            appUtilities.showStandardDialogOKEvent(viewController: viewController, title: "Warning", message: "Permission for location ungranted. Application need access for your location", event: {
                let weatherController = WeatherViewController(nibName: "WeatherViewController", bundle: nil)
                self.viewController.addWeatherPage(viewControllers: [weatherController])
            })
        }
    }
    
    fileprivate func requestWeatherDataFromAPI() {
    
    }
}
