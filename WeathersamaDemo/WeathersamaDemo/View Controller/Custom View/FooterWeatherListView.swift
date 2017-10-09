//
//  FooterWeatherListCell.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/7/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import UIKit

class FooterWeatherListView: UIView {

    @IBOutlet weak var btnAddLocation: UIButton!
    @IBOutlet weak var lblFahrenheit: UILabel!
    @IBOutlet weak var lblCelcius: UILabel!
    @IBOutlet weak var btnOpenWeatherMap: UIButton!
    
    
    @IBAction func btnAddLocationOnTouchUp(_ sender: Any) {
        let addLocationVC = WeatherSearchLocationViewController(nibName: "WeatherSearchLocationViewController", bundle: nil)
        parentViewController?.present(addLocationVC, animated: false, completion: nil)
    }
    
    @IBAction func btnOWMOnTouchUp(_ sender: Any) {
        if let url = URL(string: "https://openweathermap.org") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
