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

        // Do any additional setup after loading the view.
    }
    
    func getCurrentUserInformation() {
        UserDBHelper().getUser(username: (PFUser.current()?.username)!) { (error, user) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(user!)
            }
        }
    }
}
