//
//  GoogleSearchLocationModel.swift
//  Weathersama
//
//  Created by Saiful I. Wicaksana on 10/9/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation

public class GoogleSearchLocationModel {
    
    private let TAG = "GoogleSearchLocationModel"
    public var status: String!
    public var predictions: [Predictions] = [Predictions]()
    
    
    internal func parseJSON(jsonSerialized: AnyObject) {
        if let status = jsonSerialized["status"] as? String {
            self.status = status
        } else {
            print("\(TAG) error : JSON parse status not found")
        }
        
        if let predictions = jsonSerialized["predictions"] as? [[String: AnyObject]] {
            for prediction in predictions {
                let predictionClass = Predictions()
                if let description = prediction["description"] as? String {
                    predictionClass.description = description
                } else {
                    print("\(TAG) error : JSON parse description not found")
                }
                if let placeId = prediction["place_id"] as? String {
                    predictionClass.placeId = placeId
                } else {
                    print("\(TAG) error : JSON parse place_id not found")
                }
                self.predictions.append(predictionClass)
            }
        } else {
            print("\(TAG) error : JSON parse predictions not found")
        }
    }
}

public class Predictions {
    public var description: String!
    public var placeId: String!
}
