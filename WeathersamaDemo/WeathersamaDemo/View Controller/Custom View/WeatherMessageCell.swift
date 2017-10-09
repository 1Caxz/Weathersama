//
//  WeatherMessageUIView.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import Weathersama

class WeatherMessageCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
