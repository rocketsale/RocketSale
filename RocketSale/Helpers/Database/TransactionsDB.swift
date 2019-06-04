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
    
    static func getRecentSoldProducts(limit: Int, completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
        
        var soldProducts: [Product] = []
        
        let query = Product.query()
        query?.addDescendingOrder("createdAt")
        query?.limit = limit
        query?.findObjectsInBackground(block: { (products, error) in
            if let error = error {
                completion(error, nil)
            } else if let products = products as! [Product]? {
                
                //Only add products sold by the currrent user
                for product in products {
                    if product.seller?.objectId == PFUser.current()?.objectId {
                        if product.isPurchased{
                            soldProducts.append(product)
                        }
                    }
                }
                
                completion(nil,soldProducts)
            }
        })
    }
    
    
  
}



