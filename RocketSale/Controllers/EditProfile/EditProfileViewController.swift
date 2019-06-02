//
//  EditProfileViewController.swift
//  RocketSale
//
//  Created by Ryan M on 6/1/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse
import Foundation

class EditProfileViewController: UIViewController {

    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var interestsTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTextFields()
        roundButtonCorners()
    }
    
    func updateTextFields(){
        UserDBHelper.getUser(email: (PFUser.current()?.email)!) { (error, user) in
            if let error = error {
                print("Get User ERROR: \(error.localizedDescription)")
            } else {
                let currUser = user!
                
                self.phoneNumTextField.text = currUser.phoneNumber
                self.bioTextField.text = currUser.profileDescription
                
                var interests = ""
                for i in currUser.interests ?? [""] {
                    interests += i + " "
                }
                self.interestsTextField.text = interests
            }
        }
    }
    
    //MARK: Styling methods
    func roundButtonCorners() {
        updateButton.layer.cornerRadius = 7
        updateButton.layer.masksToBounds = true
    }
    
    //MARK: Allow user to update Profile pic??
    @IBAction func onUpdate(_ sender: Any) {
        let number = phoneNumTextField.text
        let bio = bioTextField.text
        
        let interestsText = interestsTextField.text
        let interestsArr = interestsText?.components(separatedBy: ",")
        
        UserDBHelper.updateUserAccountInformation(email: (PFUser.current()?.email)!, phoneNumber: number ?? "", description: bio ?? "", interests: interestsArr ?? [""]) { (error) in
            if let error = error {
                 print("Get Update User Info ERROR: \(error.localizedDescription)")
            }
        }
        
        performSegue(withIdentifier: "editProfileToProfile", sender: nil)
    }
    
}
