//
//  ProductAnnotation.swift
//  RocketSale
//
//  Created by Ryan Luu on 6/5/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import MapKit

class ProductAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String, price: Double, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = "\(title) (\(String(format: "$%.02f", price)))"
        self.coordinate = coordinate
        self.subtitle = subtitle
        super.init()
    }
}
