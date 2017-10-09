//
//  WeatherListViewController.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/5/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import MapKit

class WeatherListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var coreDataManager: CoreDataManager!
    fileprivate var presenter: WeatherListPresenter!
    
    internal var coord = CLLocationCoordinate2D()
    
    fileprivate var headerCell: WeatherListCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager = CoreDataManager()
        presenter = WeatherListPresenter(viewController: self)
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let player = appUtilities.setVideoUIView(view: self.tableView.backgroundView!, videoType: .CLEAR_DAY)
        appUtilities.videoAlwaysPlay(videoPlayer: player)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            coreDataManager.deleteData(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.getAllDataWeather().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as! WeatherListCell
        presenter.setDataWeatherListCell(weatherListCell: cell, longitude: coreDataManager.getSingleDataWeather(index: indexPath.row).getLongitude(), latitude: coreDataManager.getSingleDataWeather(index: indexPath.row).getLatitude())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WeatherListCell
        cell.clearConstraints()
        UIView.animate(withDuration: 0.3, animations: {
            indexPage = indexPath.row + 1
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            cell.setHeight(height: self.view.frame.height)
        }) { (result) in
//            cell.setHeight(height: self.view.frame.height)
            self.dismiss(animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    @objc func headerTableTap(sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            indexPage = 0
            self.headerCell.setHeight(height: self.view.frame.height)
        }) { (result) in
//            cell.setHeight(height: self.view.frame.height)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    fileprivate func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset.top = -20
        tableView.backgroundView = UIImageView(image: UIImage(named: "OpenWeatherLogo.png"))
        
        //set footer table
        let footerView = FooterWeatherListView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 82))
        tableView.tableFooterView = footerView
        tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "WeatherListCell")
        
        
        headerCell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell") as! WeatherListCell
        headerCell.setHeight(height: 120)
        headerCell.contentView.setHeight(height: 120)
        let playerHeader = appUtilities.setVideoUIView(view: headerCell, videoType: .CLEAR_DAY)
        tableView.tableHeaderView = headerCell.contentView
        appUtilities.videoAlwaysPlay(videoPlayer: playerHeader)
        
        presenter.setDataWeatherListCell(weatherListCell: headerCell, longitude: coord.longitude, latitude: coord.latitude)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerTableTap))
        tableView.tableHeaderView?.addGestureRecognizer(tap)
    }
}
