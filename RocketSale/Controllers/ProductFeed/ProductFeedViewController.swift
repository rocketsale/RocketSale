//
//  ProductFeedViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class ProductFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Database interaction methods
    func getRecentProducts() {
        ProductDBHelper().getMostRecentProducts(limit: 20) { (error, products) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let product = products![0].blurb
                print(product)
            }
        }
    }
    
    func purchaseProduct(objectId: String) {
        ProductDBHelper().purchaseProduct(objectId: objectId) { (error, product) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(product)
                print("saved new product info")
            }
        }
    }
}
