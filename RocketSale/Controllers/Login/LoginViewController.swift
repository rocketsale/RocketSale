//
//  LoginViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView(view: signInButton, option: "default")
        roundView(view: createAccountButton, option: "default")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        animateButtonTap(btn: signInButton)
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToHome", sender: nil)
            } else {
                let err = UIAlertController(title: "Error", message: "This account does not exist", preferredStyle: .alert)
                err.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(err, animated:true)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignup", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
