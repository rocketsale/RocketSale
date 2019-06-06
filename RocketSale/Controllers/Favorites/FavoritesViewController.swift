//
//  FavoritesViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoritesCellDelegate {
    
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
                self.displayGetFavoriteProductsError(error: error)
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
        cell.delegate = self
       
        if favoriteProducts[indexPath.row].picture != nil {
            let productImageFile = favoriteProducts[indexPath.row].picture
            productImageFile!.getDataInBackground { (imageData: Data?, error: Error?) in
                if let error = error {
                    print("Get Product Pic Error: \(error.localizedDescription)")
                }
                else if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.productImageView.image = image
                }
            }
        }
        
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
        print("At FavoritesVC Buy")
        let indexPath = self.favoritesTableView.indexPath(for: cell)!
        let chosenProduct = favoriteProducts[indexPath.row]
        purchaseProduct(product: chosenProduct, indexPath: indexPath)
    }
    
    
    func purchaseProduct(product: Product, indexPath: IndexPath) {
        ProductDBHelper.purchaseProduct(product: product) { (error, product) in
            if error != nil {
                print("Purchase Product Error: \(error?.localizedDescription)")
            } else if product != nil{
                self.favoriteProducts[indexPath.row] = product!
                //MARK: After buying remove from favorite list
                self.favoriteProducts.remove(at: indexPath.row)
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    
    func onUnFavorite(cell: FavoritesCell) {
        let indexPath = self.favoritesTableView.indexPath(for: cell)!
        let chosenProduct = favoriteProducts[indexPath.row]
        unFavoriteProduct(product: chosenProduct, indexPath: indexPath)
    }
    
    
    //MARK: Only removes from array, need to update db
    func unFavoriteProduct(product: Product, indexPath: IndexPath) {
        FavoritesDBHelper.unFavoriteProduct(selectedProduct: product) { (error, product) in
            if error != nil {
                print("UnFavorite Product Error: \(error?.localizedDescription)")
            } else if product != nil{
                self.favoriteProducts[indexPath.row] = product!
                //MARK: After unFavoriting remove from favorite list
                self.favoriteProducts.remove(at: indexPath.row)
                self.favoritesTableView.reloadData()
            }
        }
    
//        //MARK: After unFavoriting remove from favorite list
//        self.favoriteProducts.remove(at: indexPath.row)
//        self.favoritesTableView.reloadData()
    }
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    //TODO: Segue to Ryan Luu's DetailedProductScreen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController {
            let detailVC = navController.topViewController as! DetailedProductViewController
            let senderCell = sender as! UITableViewCell
            let indexPath = favoritesTableView.indexPath(for: senderCell)!
            let productData = favoriteProducts[indexPath.row]
            detailVC.product = productData
        }
    }
    
    
    //MARK: Display error functions
    func displayGetFavoriteProductsError(error: Error) {
        let title = "Error"
        let message = "Oops! Something went wrong while getting favorited products"
        print("Get Favorite Products Error: \(error.localizedDescription)")
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    
}
