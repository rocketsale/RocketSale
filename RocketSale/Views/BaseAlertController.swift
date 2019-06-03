//
//  BaseAlertController.swift
//  RocketSale
//
//  Created by Ryan Luu on 6/1/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class BaseAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func displayErrorMessage(errorMsg: String, viewController: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(title: "RocketSale", message:
            errorMsg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        viewController.present(alertController, animated: true, completion: nil)
        return alertController
    }
}
