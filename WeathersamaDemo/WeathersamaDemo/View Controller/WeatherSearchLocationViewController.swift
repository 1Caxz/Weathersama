//
//  WeatherSearchLocationViewController.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import Weathersama

class WeatherSearchLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var weathersamaForGoogle: WeathersamaForGoogle!
    fileprivate var coreDateManager: CoreDataManager!
    
    var data = [String]()
    var placeId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        tableViewSetup()
        
        weathersamaForGoogle = WeathersamaForGoogle(apiKey: googleKey)
        coreDateManager = CoreDataManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func btnCancelOnTouchUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        data.removeAll()
        placeId.removeAll()
        print(searchBar.text!)
        weathersamaForGoogle.lookingForLocationBy(input: searchBar.text!) { (isSuccess, classModel) in
            if isSuccess {
                for prediction in classModel.predictions {
                    self.data.append(prediction.description)
                    self.placeId.append(prediction.placeId)
                }
                self.tableView.reloadData()
            } else {
                print("Cannot get data fromm google")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data.removeAll()
        placeId.removeAll()
        weathersamaForGoogle.lookingForLocationBy(input: searchText) { (isSuccess, classModel) in
            if isSuccess {
                for prediction in classModel.predictions {
                    self.data.append(prediction.description)
                    self.placeId.append(prediction.placeId)
                }
                self.tableView.reloadData()
            } else {
                print("Cannot get data fromm google")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = UIColor.green
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = UIColor.clear
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        cell.selectionStyle = .gray
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .gray
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weathersamaForGoogle.getCoordinateByPlaceId(placeId: placeId[indexPath.row]) { (isSuccess, coord) in
            self.coreDateManager.addDataWeather(cityId: 123, cityName: self.data[indexPath.row], longitude: coord.longitude, latitude: coord.latitude, zipCode: 53356)
            self.dismiss(animated: true, completion: {
                let i = self.navigationController?.viewControllers.index(of: self)
                let previousViewController = self.navigationController?.viewControllers[i!-1]
                previousViewController?.viewDidAppear(true)
            })
        }
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
    
    
    fileprivate func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = nil
        tableView.backgroundColor = .clear
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
    }

}
