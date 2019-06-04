//
//  StyleHelpers.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/30/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import UIKit

//Stylings
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

//Animations
func animateButtonTap(btn: UIButton) {
    UIView.animate(withDuration: 0.1,
       animations: {
        btn.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    },
       completion: { _ in
        UIView.animate(withDuration: 0.1) {
            btn.transform = CGAffineTransform.identity
        }
    })
}
