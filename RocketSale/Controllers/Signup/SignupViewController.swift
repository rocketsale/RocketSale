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
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView(view: signUpButton, option: "default")
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
        animateButtonTap(btn: signUpButton)
        
        var msg = ""
        if usernameField.text == ""{
            msg = "Please enter a username."
            callError(msg)
        } else if emailField.text == ""{
            msg = "Please enter an email."
            callError(msg)
        } else if passwordField.text == ""{
            msg = "Please enter a password."
            callError(msg)
        } else if confirmPasswordField.text == ""{
            msg = "Please confirm your password."
            callError(msg)
        } else if passwordField.text != confirmPasswordField.text {
            msg = "You have entered different passwords."
            callError(msg)
        } else {
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.email = emailField.text
            user.signUpInBackground { (success, error) in
                if success{
                    self.signUpNewUser(self.usernameField.text!, userPassword: self.passwordField.text!)
                    PFUser.logInWithUsername(inBackground: self.usernameField.text!, password: self.passwordField.text!) { (user, error) in
                        if user != nil {
                            self.performSegue(withIdentifier: "loginToAccountInfo", sender: nil)
                        } else {
                            let err = UIAlertController(title: "Error", message: "Error in transition from signup to home.", preferredStyle: .alert)
                            err.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(err, animated:true)
                        }
                    }
                    //self.performSegue(withIdentifier: "loginToAccountInfo", sender: nil)
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func onExitSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callError(_ msg: String) {
        let err = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        err.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(err, animated:true)
    }
    
    func signUpNewUser(_ userEmail: String, userPassword: String) {
        UserDBHelper.createNewUser(email: userEmail, password: userPassword) {
            error in
            if let error = error {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AccountInformationViewController{
            let vc = segue.destination as? AccountInformationViewController
            vc?.userEmail = emailField.text!
        }
    }
}
