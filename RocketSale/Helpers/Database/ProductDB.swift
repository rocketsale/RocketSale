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
    func createNewProduct(name: String, blurb: String, price: Double, picture: PFFileObject?, completion: @escaping ((_ error: Error?) -> Void)) {
        let newProduct = Product()
        newProduct.name = name
        newProduct.blurb = blurb
        newProduct.price = price
        newProduct.picture = picture
        newProduct.saveInBackground { (success, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    //MARK: Read methods
    func getMostRecentProducts(limit: Int, completion: @escaping ((_ error: Error?, _ products: [Product]?) -> Void)) {
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
    
    func getProductById(objectId: String, completion: @escaping ((_ error: Error?, _ product: Product?) -> Void)) {
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
    func purchaseProduct(objectId: String, completion: @escaping ((_ error: Error?, _ products: Product?) -> Void)) {
        let query = Product.query()
        query?.whereKey("objectId", equalTo: objectId)
        query?.getFirstObjectInBackground(block: { (product, error) in
            if let error = error {
                completion(error, nil)
            } else if let product = product as! Product? {
                product.isPurchased = true
                product.purchaser = PFUser.current() as! User
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
    
    func favoriteProduct() {
        
    }
}
