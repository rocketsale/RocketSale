//
//  FavoritesViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favoriteProducts: [Product] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        getFavoriteProducts()
        setupRefreshControl()
    }
    
    //MARK: Data reload methods
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(getFavoriteProducts), for: .valueChanged)
        favoritesTableView.refreshControl = refreshControl
    }
    
    //MARK: DatabaseHelper interaction methods
    @objc func getFavoriteProducts() {
        FavoritesDBHelper.getAllFavorites { (error, products) in
            if let error = error {
                print(error.localizedDescription)
            } else if products != nil {
                self.favoriteProducts = products!
                self.favoritesTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesCell
       
        //cell.productImageView.image = products[indexPath.row].picture
        cell.productNameLabel.text = favoriteProducts[indexPath.row].name
        cell.productDescLabel.text = favoriteProducts[indexPath.row].blurb
        cell.productPriceLabel.text = String(format: "$%.02f", favoriteProducts[indexPath.row].price)
        
        if favoriteProducts[indexPath.row].isPurchased == true {
            cell.buyButton.isHidden = true
        } else {
            cell.buyButton.isHidden = false
        }

        return cell
    }
    
    func onBuyButton(cell: FavoritesCell) {
        let indexPath = self.favoritesTableView.indexPath(for: cell)!
        let chosenProduct = favoriteProducts[indexPath.row]
        purchaseProduct(product: chosenProduct, indexPath: indexPath)
    }
    
    func purchaseProduct(product: Product, indexPath: IndexPath) {
        ProductDBHelper.purchaseProduct(product: product) { (error, product) in
            if error != nil {
                print(error?.localizedDescription)
            } else if product != nil{
                self.favoriteProducts[indexPath.row] = product!
                
                //MARK: After buying remove from favorite list?
                //self.favoriteProducts.remove(at: indexPath.row)
               
                self.favoritesTableView.reloadData()
            }
        }
    }
    
 
}
