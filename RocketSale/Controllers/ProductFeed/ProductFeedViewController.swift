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
}
