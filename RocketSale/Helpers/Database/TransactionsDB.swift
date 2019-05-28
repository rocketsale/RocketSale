//
//  TransactionsDB.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class TransactionsDBHelper {

    static func getSoldProducts(completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
        var products: [Product] = []
        
        let query = User.query()
        query?.whereKey("email", equalTo: PFUser.current()?.email!)
        query?.addDescendingOrder("createdAt")
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                if let favoritedProducts = user.favoritedProducts {
                    
                    //Only add products sold by the currrent user
                    for product in user.favoritedProducts! {
                        if product.seller == PFUser.current() {
                            if product.isPurchased{
                                products.append(product)
                            }
                        }
                    }
                    
                }
                completion(nil, products)
            }
        })
    }
}
