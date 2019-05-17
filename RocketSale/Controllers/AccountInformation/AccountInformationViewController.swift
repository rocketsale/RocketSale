//
//  AccountInformationViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class AccountInformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDBHelper().initializeUserAccountInformation(email: "rnluu@uci.edu", description: "yaboi", interests: ["stussy", "supreme"], profilePicture: nil) {
            error in
            if let error = error {
                print(error)
            } else {
                print("we good")
            }
        }
    }
}
