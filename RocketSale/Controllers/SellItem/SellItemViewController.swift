//
//  SellItemViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class SellItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createNewProductForSale() {
        ProductDBHelper().createNewProduct(name: "rug", blurb: "super fulfyy", price: 6.20, picture: nil) {
            error in
            if let error = error {
                print(error)
            } else {
                print("yep saved a new product")
            }
        }
    }
}
