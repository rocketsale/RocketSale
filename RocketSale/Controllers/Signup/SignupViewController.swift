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

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        ProductDBHelper.createNewProduct(name: "book", blurb: "very entertaining", price: 10.50, picture: nil, tags: nil) {
//            error in
//            if let error = error {
//                print(error)
//            } else {
//                print("yep saved a new product")
//            }
//        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginToAccountInfo", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
//    func signUpNewUser() {
//        UserDBHelper.createNewUser(email: "ryan@uci.edu", password: "yeeet") {
//            error in
//            if let error = error {
//                print(error)
//            } else {
//                print("we good")
//            }
//        }
//    }
}
