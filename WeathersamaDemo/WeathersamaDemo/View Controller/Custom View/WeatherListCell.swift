//
//  CustomWeatherListUIView.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/5/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet var viewContent: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTemperature.adjustsFontSizeToFitWidth = true
        lblCityName.adjustsFontSizeToFitWidth = true
        lblTime.adjustsFontSizeToFitWidth = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
