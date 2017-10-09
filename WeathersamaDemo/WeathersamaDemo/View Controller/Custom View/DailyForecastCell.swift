//
//  DailyForecastUIView.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import Weathersama

class DailyForecastCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var day5: UILabel!
    @IBOutlet weak var day6: UILabel!
    @IBOutlet weak var day7: UILabel!
    
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var icon5: UIImageView!
    @IBOutlet weak var icon6: UIImageView!
    @IBOutlet weak var icon7: UIImageView!
    
    @IBOutlet weak var tempMax1: UILabel!
    @IBOutlet weak var tempMax2: UILabel!
    @IBOutlet weak var tempMax3: UILabel!
    @IBOutlet weak var tempMax4: UILabel!
    @IBOutlet weak var tempMax5: UILabel!
    @IBOutlet weak var tempMax6: UILabel!
    @IBOutlet weak var tempMax7: UILabel!
    
    @IBOutlet weak var tempMin1: UILabel!
    @IBOutlet weak var tempMin2: UILabel!
    @IBOutlet weak var tempMin3: UILabel!
    @IBOutlet weak var tempMin4: UILabel!
    @IBOutlet weak var tempMin5: UILabel!
    @IBOutlet weak var tempMin6: UILabel!
    @IBOutlet weak var tempMin7: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
