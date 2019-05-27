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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        makeDummyUser()
        getCurrentUserInformation()
        // Do any additional setup after loading the view.
    }
    
    func makeDummyUser(){
//        UserDBHelper.createNewUser(email: "ryan@gmail.com", password: "0123") { (error) in
//            if let error = error {
//                print("ERROR: \(error.localizedDescription)")
//            }
//            else {
//                print("User created")
//            }
//        }
        UserDBHelper.initializeUserAccountInformation(email: "ryan@gmail.com", phoneNumber: "4081234567", description: "Tester", interests: ["food", "skateboarding"], profilePicture: nil) { (error) in
            if let error = error {
                 print("ERROR: \(error.localizedDescription)")
            }
            else{
                print("User info updated")
            }
        }
    }
    
    func getCurrentUserInformation() {
        UserDBHelper.getUser(email: "ryan@gmail.com") { (error, user) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print(user!)
            }
        }
    }
}
