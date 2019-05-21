//
//  FavoritesViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favoriteProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavoriteProducts()
    }
    
    func getFavoriteProducts() {
        FavoritesDBHelper.getAllFavorites { (error, products) in
            if let error = error {
                print(error.localizedDescription)
            } else if products != nil {
                self.favoriteProducts = products!
            }
        }
    }
}
