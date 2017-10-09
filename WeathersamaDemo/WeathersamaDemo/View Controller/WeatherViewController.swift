//
//  MainViewController.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/4/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import AVFoundation
import Weathersama
import MapKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let TAG = "WeatherViewController"
    
    fileprivate var assetManager: AssetManager!
    fileprivate var header : StretchHeaderLists!
    fileprivate var presenter: WeatherPresenter!
    fileprivate var player: AVPlayer!
    
    internal var coord = CLLocationCoordinate2D()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var currentDay: UILabel!
    
    fileprivate var forecastScrollCell: ForecastScrollCell!
    fileprivate var dailyForecastCell: DailyForecastCell!
    fileprivate var weatherDetailCell: WeatherDetailCell!
    fileprivate var weatherMessageCell: WeatherMessageCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        presenter = WeatherPresenter(viewController: self)
        assetManager = AssetManager()
        viewSetup()
        tableViewSetup()
        setupHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.requestWeatherData(coord: coord) {
            self.startVideoBackground(weatherVideo: self.assetManager.getWeatherCondition(weather: self.presenter.getWeatherModel().weather[0].description, hour: Int(appUtilities.getHour(timeInterval: self.presenter.getWeatherModel().dt))!))
            self.presenter.generateWeatherData()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        forecastScrollCell = tableView.dequeueReusableCell(withIdentifier: "ForecastScrollCell") as! ForecastScrollCell
        if presenter.isDataLoaded {
            presenter.setDataForecastScrollCell(forecastScrollCell: forecastScrollCell, forecastModel: presenter.getForecastModel(), weatherModel: presenter.getWeatherModel())
        }
        return forecastScrollCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if indexPath.row == 0 {
            dailyForecastCell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastCell", for: indexPath) as! DailyForecastCell
            if presenter.isDataLoaded {
                presenter.setDataDailyForecast(dailyForecastCell: dailyForecastCell, dailyForecastModel: presenter.getDailyForecastModel())
            }
            cell = dailyForecastCell
        } else if indexPath.row == 1 {
            weatherMessageCell = tableView.dequeueReusableCell(withIdentifier: "WeatherMessageCell", for: indexPath) as! WeatherMessageCell
            if presenter.isDataLoaded {
                presenter.setDataWeatherMessageCell(weatherMessageCell: weatherMessageCell, weatherModel: presenter.getWeatherModel())
            }
            cell = weatherMessageCell
        } else {
            weatherDetailCell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailCell
            if presenter.isDataLoaded {
                if indexPath.row == 2 && presenter.getWeatherModel().isDataExist {
                    presenter.setDataWeatherDetailCell(weatherDetailCell: weatherDetailCell, leftTitle: "SUNRISE", leftValue: appUtilities.getTime(timeInterval: presenter.getWeatherModel().sys.sunrise ?? 0), rightTitle: "SUNSET", rightValue: appUtilities.getTime(timeInterval: presenter.getWeatherModel().sys.sunset ?? 0))
                } else if indexPath.row == 3 && presenter.getWeatherModel().isDataExist {
                    presenter.setDataWeatherDetailCell(weatherDetailCell: weatherDetailCell, leftTitle: "CHANCE OF RAIN", leftValue: "\(presenter.getWeatherModel().rain.threeHours ?? 0)%", rightTitle: "HUMIDITY", rightValue: "\(presenter.getWeatherModel().main.humidity ?? 0)%")
                } else if indexPath.row == 4 && presenter.getWeatherModel().isDataExist {
                    presenter.setDataWeatherDetailCell(weatherDetailCell: weatherDetailCell, leftTitle: "WIND", leftValue: "\(appUtilities.getWindDirection(fromDegrees: Float(presenter.getWeatherModel().wind.deg ?? 0))) \(presenter.getWeatherModel().wind.speed ?? 0) km/hr", rightTitle: "FEELS LIKE", rightValue: "\(presenter.getWeatherModel().main.temperatureMax ?? 0)\u{00B0}")
                } else if indexPath.row == 5 && presenter.getWeatherModel().isDataExist {
                    presenter.setDataWeatherDetailCell(weatherDetailCell: weatherDetailCell, leftTitle: "PRECIPITATION", leftValue: "\(((presenter.getWeatherModel().rain.threeHours ?? 0) / 10)) cm", rightTitle: "PRESSURE", rightValue: "\(presenter.getWeatherModel().main.pressure ?? 0) hPa")
                } else if indexPath.row == 6 && presenter.getWeatherModel().isDataExist {
                    presenter.setDataWeatherDetailCell(weatherDetailCell: weatherDetailCell, leftTitle: "VISIBILITY", leftValue: "\(((presenter.getWeatherModel().visibility ?? 0)/1000)) km", rightTitle: "UV INDEX", rightValue: "\(presenter.getUVIndex())")
                }
            }
            cell = weatherDetailCell
            cell.separatorInset.left = 15
            cell.separatorInset.right = 15
        }
        if indexPath.row == 6 {
            cell.separatorInset = UIEdgeInsetsMake(0, self.view.bounds.width, 0, 0)
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        cityName.adjustsFontSizeToFitWidth = true
        tempMax.adjustsFontSizeToFitWidth = true
        tempMin.adjustsFontSizeToFitWidth = true
        temperature.adjustsFontSizeToFitWidth = true
        weatherType.adjustsFontSizeToFitWidth = true
    }
    
    fileprivate func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = nil
        tableView.backgroundColor = .clear
        
        tableView.register(UINib(nibName: "ForecastScrollCell", bundle: nil), forCellReuseIdentifier: "ForecastScrollCell")
        tableView.register(UINib(nibName: "DailyForecastCell", bundle: nil), forCellReuseIdentifier: "DailyForecastCell")
        tableView.register(UINib(nibName: "WeatherDetailCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailCell")
        tableView.register(UINib(nibName: "WeatherMessageCell", bundle: nil), forCellReuseIdentifier: "WeatherMessageCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
    }
    
    func setupHeaderView() {
        let options = StretchHeaderOptions()
        options.position = .underNavigationBar
        header = StretchHeaderLists()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 140),
                                 imageSize: CGSize(width: view.frame.size.width, height: 140),
                                 controller: self,
                                 options: options)
        header.backgroundColor = .clear
        tableView.tableHeaderView = header
    }
    
    fileprivate var isTop = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alphaValue = (scrollView.contentOffset.y / (scrollView.bounds.size.height/4))
        temperature.alpha = 1 - (alphaValue + 0.3)
        tempMax.alpha = 1 - (alphaValue + 0.4)
        tempMin.alpha = 1 - (alphaValue + 0.4)
        currentDay.alpha = 1 - (alphaValue + 0.4)
        header.updateScrollViewOffset(scrollView)
    }
    
    @objc func viewDidBecomeActive() {
        if player != nil {
            appUtilities.videoAlwaysPlay(videoPlayer: player)
        }
    }
    
    internal func startVideoBackground(weatherVideo: AssetManager.WEATHER_VIDEO) {
        appUtilities.delay(second: 0.3) {
            UIView.animate(withDuration: 0.5, animations: {
                self.player = appUtilities.setVideoUIView(view: self.view, videoType: weatherVideo)
            })
            appUtilities.videoAlwaysPlay(videoPlayer: self.player)
            NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        }
    }
}
