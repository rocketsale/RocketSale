//
//  ProfileViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var numTransactionsLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInformation()
    }
    
    func makeDummyUser(){
        UserDBHelper.createNewUser(email: "ryan@gmail.com", password: "0123") { (error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            else {
                print("User created")
            }
        }
    }
    
    func fillDummyUser() {
        UserDBHelper.initializeUserAccountInformation(email: "ryan@gmail.com", phoneNumber: "4081234567", description: "Tester", interests: ["food", "skateboarding"], profilePicture: nil) { (error) in
            if let error = error {
                 print("ERROR: \(error.localizedDescription)")
            }
            else{
                print("User info updated")
            }
        }
    }
    
    func updateUserInformation() {
        UserDBHelper.getUser(email: (PFUser.current()?.email)!) { (error, user) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                let currUser = user!
        
                self.usernameLabel.text = currUser.username
                self.phoneNumberLabel.text = currUser.phoneNumber
                self.numTransactionsLabel.text = "\(currUser.numberOfItemsSold + currUser.numberOfItemsBought)"
                self.descriptionLabel.text = currUser.profileDescription
                
                var interests = ""
                for i in currUser.interests ?? [""] {
                    interests += i + " "
                }
                self.interestsLabel.text = interests
                
                if currUser.profilePicture != nil {
                    let userImageFile = currUser.profilePicture!
                    
                    userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        else if let imageData = imageData {
                            let image = UIImage(data:imageData)
                            self.ProfilePic.image = image
                        }
                    }
                }
                
            }
        }
    }
    
    //TODO: Add identifier to LoginViewController
    @IBAction func onLogout(_ sender: Any) {
//        //User.logOut()
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginVC = main.instantiateViewController(withIdentifier: "LoginViewController")
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        delegate.window?.rootViewController = loginVC
    }
    
    //TODO: Add default profile picture image to Xcode
    
}
