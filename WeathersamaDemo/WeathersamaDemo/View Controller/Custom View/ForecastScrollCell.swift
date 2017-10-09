//
//  ForecastScrollView.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit
import Weathersama

class ForecastScrollCell: UITableViewCell {
    
    @IBOutlet var scrollView: UIScrollView!
    
    internal func addViewWeather(hour: String, imageURL: String, temp: String, dynamicX: Double) {
        
        var width = 50
        if temp == "Sunset" || temp == "Sunrise"  || hour == "Now" {
            width = 75
        }
        
        let view = UIView(frame: CGRect(x: dynamicX, y: 0.0, width: Double(width), height: Double(scrollView.bounds.height)))
        
        let labelTop = UILabel(frame: CGRect(x: 0, y: 8, width: width, height: 15))
        labelTop.text = hour
        labelTop.textAlignment = .center
        labelTop.font = labelTop.font.withSize(15)
        labelTop.textColor = .white
        labelTop.adjustsFontSizeToFitWidth = true
        
        let imageMiddle = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        if temp == "Sunset" || temp == "Sunrise" {
            imageMiddle.image = UIImage(named: imageURL)
        } else {
            imageMiddle.imageFrom(link: imageURL)
        }
        imageMiddle.center.y = view.center.y
        imageMiddle.center.x = view.frame.width / 2
        imageMiddle.contentMode = .scaleAspectFit
        
        let labelBottom = UILabel(frame: CGRect(x: 0, y: Int(view.frame.height - 28), width: width, height: 20))
        labelBottom.text = "\(temp)"
        labelBottom.font = labelBottom.font.withSize(20)
        labelBottom.textAlignment = .center
        labelBottom.textColor = .white
        labelBottom.adjustsFontSizeToFitWidth = true
        
        if labelTop.text == "Now" {
            labelTop.font = UIFont.boldSystemFont(ofSize: 15.0)
            labelBottom.font = UIFont.boldSystemFont(ofSize: 20.0)
        }
        
        view.addSubview(labelTop)
        view.addSubview(imageMiddle)
        view.addSubview(labelBottom)
        scrollView.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
