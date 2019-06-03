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
                    products = favoritedProducts
                }
                completion(nil, products)
            }
        })
    }
    
    //MARK: Delete method
    static func unFavoriteProduct(selectedProduct: Product, completion: @escaping ((_ error: Error?, _ product: Product?) -> Void)) {
        let query = User.query()
        query?.whereKey("email", equalTo: PFUser.current()?.email)
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                
                //Remove selected product from current user's favoriteProducts list
                if user.favoritedProducts?.count ?? 0 > 0 {
                    for index in 0...(user.favoritedProducts!.count - 1) {
                        if user.favoritedProducts?[index].objectId == selectedProduct.objectId {
                            user.favoritedProducts?.remove(at: index)
                            break
                        }
                    }
                }
                
                user.saveInBackground(block: { (success, error) in
                    if let error = error {
                        completion(error, nil)
                    } else {
                        let prodQuery = Product.query()
                        prodQuery?.whereKey("objectId", equalTo: selectedProduct.objectId!)
                        prodQuery?.includeKey("favoritedUser")
                        prodQuery?.getFirstObjectInBackground(block: { (product, error) in
                            if let error = error {
                                completion(error, nil)
                            } else if let product = product as! Product? {
                                
                                //remove current user from selecetd product's favoritedUsers list
                                if product.favoritedUser?.count ?? 0 > 0 {
                                    for index in 0...(product.favoritedUser!.count - 1){
                                        if product.favoritedUser?[index].objectId == PFUser.current()?.objectId {
                                            product.favoritedUser?.remove(at: index)
                                            break
                                        }
                                    }
                                }
                                
                                product.saveInBackground(block: { (success, error) in
                                    if let error = error {
                                        completion(error, nil)
                                    } else {
                                        completion(nil, product)
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    }
    
}
