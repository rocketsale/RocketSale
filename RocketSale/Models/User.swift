//
//  User.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/16/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class User: PFUser {
    @NSManaged var phoneNumber: String?
    @NSManaged var profilePicture: PFFileObject?
    @NSManaged var interests: [String]?
    @NSManaged var profileDescription: String?
    @NSManaged var numberOfItemsBought: Int
    @NSManaged var numberOfItemsUpForSale: Int
    @NSManaged var numberOfItemsSold: Int
    @NSManaged var favoritedProducts: [Product]?
    @NSManaged var purchasedProducts: [Product]?
}
