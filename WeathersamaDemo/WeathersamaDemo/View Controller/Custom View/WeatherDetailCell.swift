//
//  WeatherDetailViewController.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit

class WeatherDetailCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var leftValue: UILabel!
    @IBOutlet weak var rightTitle: UILabel!
    @IBOutlet weak var rightValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
