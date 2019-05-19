//
//  SignupViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ProductDBHelper().createNewProduct(name: "book", blurb: "very entertaining", price: 10.50, picture: nil, tags: nil) {
            error in
            if let error = error {
                print(error)
            } else {
                print("yep saved a new product")
            }
        }
    }
    
    func signUpNewUser() {
        UserDBHelper().createNewUser(email: "ryan@uci.edu", password: "yeeet") {
            error in
            if let error = error {
                print(error)
            } else {
                print("we good")
            }
        }
    }
}
