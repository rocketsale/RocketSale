//
//  Product.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/16/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class Product: PFObject, PFSubclassing {
    @NSManaged var name: String?
    @NSManaged var blurb: String?
    @NSManaged var price: Double
    @NSManaged var picture: PFFileObject?
    
    static func parseClassName() -> String {
        return "Product"
    }
}
