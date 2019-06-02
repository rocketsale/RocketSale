//
//  EditProfileViewController.swift
//  RocketSale
//
//  Created by Ryan M on 6/1/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: Profile picture?
    func updateUserInfo(phoneNumber: String, description: String, interests: [String] ) {
        UserDBHelper.updateUserAccountInformation(email: (PFUser.current()?.email)!, phoneNumber: phoneNumber, description: description, interests: interests) { (error) in
            if let error = error {
                print("Update User Info Error: \(error.localizedDescription)")
            }
        }
    }

}
