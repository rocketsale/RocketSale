//
//  ProductFeedViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class ProductFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductCellDelegate {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        roundButtonCorners()
        getRecentProducts()
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRecentProducts()
    }
    
    //MARK: Styling methods
    func roundButtonCorners() {
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
    }
    
    //MARK: Data reload methods
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(getRecentProducts), for: .valueChanged)
        productTableView.refreshControl = refreshControl
    }
    
    //MARK: TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrototypeCellNames.ProductFeedCell) as! ProductCell
        cell.delegate = self
        //cell.productImageView.image = products[indexPath.row].picture
        cell.productName.text = products[indexPath.row].name
        cell.productBlurb.text = products[indexPath.row].blurb
        cell.productPrice.text = String(format: "$%.02f", products[indexPath.row].price)
        
        if products[indexPath.row].picture != nil {
            let urlString = products[indexPath.row].picture!.url!
            let url = URL(string: urlString)
            cell.productImageView.af_setImage(withURL: url!)
        }
        
        if products[indexPath.row].isPurchased == true {
            cell.buyButton.isHidden = true
        } else {
            cell.buyButton.isHidden = false
        }
        
        if isProductFavorited(users: products[indexPath.row].favoritedUser) {
            cell.favoriteButton.backgroundColor = UIColor.white
        }
        return cell
    }
    
    @IBAction func onSearchTap(_ sender: Any) {
        
    }
    
    func onBuyTap(cell: ProductCell) {
        let indexPath = self.productTableView.indexPath(for: cell)!
        let chosenProduct = products[indexPath.row]
        purchaseProduct(product: chosenProduct, indexPath: indexPath)
    }
    
    func onFavoriteTap(cell: ProductCell) {
        let indexPath = self.productTableView.indexPath(for: cell)!
        let chosenProduct = products[indexPath.row]
        favoriteProduct(product: chosenProduct, indexPath: indexPath)
    }
    
    //MARK: Interactivity method
    @IBAction func onSellTap(_ sender: Any) {
    }
    
    //MARK: Database interaction methods
    @objc func getRecentProducts() {
        ProductDBHelper.getMostRecentProducts(limit: 20) { (error, products) in
            if let error = error {
                print(error.localizedDescription)
            } else if products != nil {
                self.products = products!
                self.productTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func purchaseProduct(product: Product, indexPath: IndexPath) {
        ProductDBHelper.purchaseProduct(product: product) { (error, product) in
            if error != nil {
                print(error?.localizedDescription)
            } else if product != nil{
                self.products[indexPath.row] = product!
                self.productTableView.reloadData()
            }
        }
    }
    
    func favoriteProduct(product: Product, indexPath: IndexPath) {
        ProductDBHelper.favoriteProduct(product: product) { (error, product) in
            if let error = error {
                print(error.localizedDescription)
            } else if product != nil {
                self.products[indexPath.row] = product!
                self.productTableView.reloadData()
            }
        }
    }
    
    //MARK: Helper methods
    func isProductFavorited(users: [User]?) -> Bool {
        if let users = users {
            for user in users {
                print(user)
                if user.objectId! == PFUser.current()?.objectId! {
                    return true
                }
            }
        }
        return false
    }
}
