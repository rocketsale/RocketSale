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
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        setStyles()
        setupRefreshControl()
        getRecentProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ((searchTextField.text?.isEmpty)!) {
            getRecentProducts()
        }
    }
    
    //MARK: Styling methods
    func setStyles() {
        roundView(view: searchButton, option: "default")
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
        setCellPicture(picture: products[indexPath.row].picture, cell: cell)
        setCellPurchasedStatus(isPurchased: products[indexPath.row].isPurchased, cell: cell)
        setCellFavoritedStatus(favoritedUsers: products[indexPath.row].favoritedUser, cell: cell)
        return cell
    }
    
    func setCellPicture(picture: PFFileObject?, cell: ProductCell) {
        if picture != nil {
            let urlString = picture!.url!
            let url = URL(string: urlString)
            cell.productImageView.af_setImage(withURL: url!)
        }
    }
    
    func setCellPurchasedStatus(isPurchased: Bool, cell: ProductCell) {
        if isPurchased {
            cell.buyButton.isHidden = true
        } else {
            cell.buyButton.isHidden = false
        }
    }
    
    func setCellFavoritedStatus(favoritedUsers: [User]?, cell: ProductCell) {
        if isProductFavorited(users: favoritedUsers) {
            cell.favoriteButton.backgroundColor = UIColor.init(red: 206/256, green: 17/256, blue: 65/256, alpha: 1)
            cell.favoriteButton.setTitleColor(.white, for: .normal)
            cell.favoriteButton.setTitle("Liked", for: .normal)
        } else {
            cell.favoriteButton.backgroundColor = UIColor.gray
            cell.favoriteButton.setTitleColor(.white, for: .normal)
            cell.favoriteButton.setTitle("Like", for: .normal)
        }
    }
    
    
    //MARK: Interactivity method
    @IBAction func onSearchTap(_ sender: Any) {
        animateButtonTap(btn: searchButton)
        handleSearch()
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
    
    @IBAction func onSellTap(_ sender: Any) {
    }
    
    //MARK: Database interaction methods
    @objc func getRecentProducts() {
        ProductDBHelper.getMostRecentProducts(limit: 20) { (error, products) in
            if let error = error {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not get most recent products", viewController: self)
            } else if products != nil {
                self.products = products!
                self.productTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func getProductsBySearchTerm(searchTerm: String) {
        ProductDBHelper.getProductsBySearchTerm(searchTerm: searchTerm, limit: 20) { (error, products) in
            if let error = error {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not get products by search term", viewController: self)
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
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not purchase product", viewController: self)
            } else if product != nil{
                self.products[indexPath.row] = product!
                self.productTableView.reloadData()
            }
        }
    }
    
    func favoriteProduct(product: Product, indexPath: IndexPath) {
        ProductDBHelper.favoriteProduct(product: product) { (error, product) in
            if let error = error {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not favorite product", viewController: self)
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
                if user.objectId! == PFUser.current()?.objectId! {
                    return true
                }
            }
        }
        return false
    }
    
    func handleSearch() {
        if !self.searchTextField.text!.isEmpty {
            self.getProductsBySearchTerm(searchTerm: self.searchTextField.text!)
        } else {
            self.getRecentProducts()
        }
    }
    
    //MARK: Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Gets the exact array
        if segue.identifier == "productDetailSegue" {
            let senderCell = sender as! UITableViewCell
            let indexPath = productTableView.indexPath(for: senderCell)!
            let productData = products[indexPath.row]

            //Passes data to detail view
            let detailedProductFeedVC = segue.destination as! DetailedProductViewController
            detailedProductFeedVC.product = productData
        }
        
        if segue.identifier == "mapSegue" {
            //Passes data to detail view
            let productMapVC = segue.destination as! ProductMapViewController
            productMapVC.products = products
        }
    }
}
