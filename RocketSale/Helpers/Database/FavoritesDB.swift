//
//  FavoritesDB.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/19/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class FavoritesDBHelper {
    
    //MARK: Create methods
    
    //MARK: Read methods
    static func getAllFavorites(completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
        var products: [Product] = []
        
        let query = User.query()
        query?.whereKey("email", equalTo: PFUser.current()?.email!)
        query?.addDescendingOrder("createdAt")
        query?.includeKey("favoritedProducts")
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                if let favoritedProducts = user.favoritedProducts {
                    
                    //MARK: only add products still available for purchase to favorites screen?
//                    for product in user.favoritedProducts! {
//                        if !product.isPurchased {
//                            products.append(product)
//                        }
//                    }
                    
                    products = favoritedProducts
                }
                completion(nil, products)
            }
        })
    }
    
    //MARK: Update methods
}
