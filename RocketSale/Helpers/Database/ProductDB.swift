//
//  ProductDB.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import Foundation
import Parse

class ProductDBHelper {
    
    //MARK: Create methods
    static func createNewProduct(name: String, blurb: String, price: Double, picture: PFFileObject?, tags: [String]?, latitude: Double, longitude: Double, completion: @escaping ((_ error: Error?) -> Void)) {
        let newProduct = Product()
        newProduct.name = name
        newProduct.blurb = blurb
        newProduct.price = price
        newProduct.picture = picture
        newProduct.tags = tags
        newProduct.latitude = latitude
        newProduct.longitude = longitude
        if let user = PFUser.current() as! User? {
            newProduct.seller = user
        }
        newProduct.saveInBackground { (success, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    //MARK: Read methods
    static func getMostRecentProducts(limit: Int, completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
        let query = Product.query()
        query?.addDescendingOrder("createdAt")
        query?.limit = limit
        query?.findObjectsInBackground(block: { (products, error) in
            if let error = error {
                completion(error, nil)
            } else if let products = products as! [Product]? {
                completion(nil, products)
            }
        })
    }
    
    static func getProductsBySearchTerm(searchTerm: String, limit: Int, completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
        let query = Product.query()
        query?.addDescendingOrder("createdAt")
        query?.whereKey("blurb", matchesText: searchTerm)
        query?.limit = limit
        query?.findObjectsInBackground(block: { (products, error) in
            if let error = error {
                completion(error, nil)
            } else if let products = products as! [Product]? {
                completion(nil, products)
            }
        })
    }
    
    static func getProductById(objectId: String, completion: @escaping ((_ error: Error?, _ product: Product?) -> Void)) {
        let query = Product.query()
        query?.whereKey("objectId", equalTo: objectId)
        query?.getFirstObjectInBackground(block: { (product, error) in
            if let error = error {
                completion(error, nil)
            } else if let product = product as! Product? {
                completion(nil, product)
            }
        })
    }
    
    //MARK: Update methods
    static func purchaseProduct(product: Product, completion: @escaping ((_ error: Error?, _ product: Product?) -> Void)) {
        let query = User.query()
        query?.whereKey("email", equalTo: PFUser.current()?.email)
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                if user.purchasedProducts != nil {
                    user.purchasedProducts?.append(product)
                } else {
                    user.purchasedProducts = [product]
                }
                user.saveInBackground(block: { (success, error) in
                    if let error = error {
                        completion(error, nil)
                    } else {
                        let query = Product.query()
                        query?.whereKey("objectId", equalTo: product.objectId!)
                        query?.getFirstObjectInBackground(block: { (product, error) in
                            if let error = error {
                                completion(error, nil)
                            } else if let product = product as! Product? {
                                product.isPurchased = true
                                product.purchaser = user
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
    
    static func favoriteProduct(product: Product, completion: @escaping ((_ error: Error?, _ product: Product?) -> Void)) {
        let query = User.query()
        query?.whereKey("email", equalTo: PFUser.current()?.email)
        query?.getFirstObjectInBackground(block: { (user, error) in
            if let error = error {
                completion(error, nil)
            } else if let user = user as! User? {
                if user.favoritedProducts != nil {
                    user.favoritedProducts?.append(product)
                } else {
                    user.favoritedProducts = [product]
                }
                user.saveInBackground(block: { (success, error) in
                    if let error = error {
                        completion(error, nil)
                    } else {
                        let prodQuery = Product.query()
                        prodQuery?.whereKey("objectId", equalTo: product.objectId!)
                        prodQuery?.includeKey("favoritedUser")
                        prodQuery?.getFirstObjectInBackground(block: { (product, error) in
                            if let error = error {
                                completion(error, nil)
                            } else if let product = product as! Product? {
                                if product.favoritedUser != nil {
                                    product.favoritedUser?.append(user)
                                } else {
                                    product.favoritedUser = [user]
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
