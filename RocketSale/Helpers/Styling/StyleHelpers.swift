//
//  StyleHelpers.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/30/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import UIKit

func roundView(view: UIView, option: String) {
    view.layer.masksToBounds = true
    switch(option) {
    case "default":
        view.layer.cornerRadius = 5
        return
    case "rounded":
        view.layer.cornerRadius = view.frame.height/2
        return
    default:
        return
    }
}
