//
//  Constants.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/15/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

// This file has all of the constants as enums that are related to specific types of functionality and purposes

import UIKit

enum Color {
    static let primaryColor = UIColor(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
    static let secondaryColor = UIColor.lightGray
    static let tertiaryColor = #colorLiteral(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
    static let uglyColor = UIColor(red: 0.11, green: 0.66, blue: 0.33, alpha: 1.0)
}

enum BaseURLs {
    static let twitterURL = NSURL(string: "https://twitter.com/api")!
    static let facebookURL = NSURL(string: "https://facebook.com/api")!
}

enum PrototypeCellNames {
    static let ProductFeedCell = "productFeedCell"
    static let TransactionListCell = "transactionListCell"
}
