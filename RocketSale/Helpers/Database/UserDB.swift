//
//  UserDbHelper.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class UserDBHelper {
    
    // MARK: Create methods
    func createNewUser(email: String, password: String, completion: @escaping ((_ error: Error?) -> Void)) {
        let newUser = User()
         newUser.username = email
         newUser.email = email
         newUser.password = password
         newUser.signUpInBackground { (success, error) in
            if let error = error {
                completion(error)
                print(error.localizedDescription)
            } else {
                completion(nil)
                print("new user created")
            }
        }
    }
    
    // MARK: Read methods
    func getUser(username: String, completion: @escaping ((_ error: Error?, _ user: User?) -> Void)) {
        let query = User.query()
        query?.whereKey("username", equalTo: username)
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                completion(nil, user)
            }
        })
    }
    
    // MARK: Update methods
    func initializeUserAccountInformation(email: String, description: String, interests: [String], profilePicture: PFFileObject?, completion: @escaping ((_ error: Error?) -> Void)) {
        let query = User.query()
        query?.whereKey("email", equalTo: email)
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error)
            } else {
                let user = user as? User
                user?.profileDescription = description
                user?.interests = interests
                user?.profilePicture = profilePicture
                user?.numberOfItemsBought = 0
                user?.numberOfItemsSold = 0
                user?.saveInBackground(block: { (success, error) in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                })
            }
        })
    }
    
    //MARK: Delete methods
}
