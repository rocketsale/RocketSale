//
//  DetailedProductViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class DetailedProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Databse interaction methods
    func getProductInformation() {
        ProductDBHelper.getProductById(objectId: "CKTrE8p9Bp") { (error, product) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(product)
            }
        }
    }
}
