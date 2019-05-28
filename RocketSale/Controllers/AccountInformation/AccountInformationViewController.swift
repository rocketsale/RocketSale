//
//  AccountInformationViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.


import UIKit

class AccountInformationViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var livingAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDBHelper().initializeUserAccountInformation(email: "rnluu@uci.edu", phoneNumber: "6262780357", description: "yaboi", interests: ["stussy", "supreme"], profilePicture: nil) {
//            error in
//            if let error = error {
//                print(error)
//            } else {
//                print("we good")
//            }
//        }

    }
}
