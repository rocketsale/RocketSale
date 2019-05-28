//
//  TransactionsViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Parse

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productsTableView: UITableView!
    
    var products: [Product] = []
    var boughtProducts: [Product] = []
    var soldProducts: [Product] = []
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productsTableView.delegate = self
        productsTableView.dataSource = self
        setupRefreshControl()
        
        getProducts(_type: 0)
    }
    
    
    //MARK: Data reload methods
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(getProducts), for: .valueChanged)
        productsTableView.refreshControl = refreshControl
    }
    
    
    @objc func getProducts(_type: Int = 0) {
        var type = _type
        if type > 2 {
            type = 0
        }
        
        if type == 0 {
            getBought()
            getSold()
            products = boughtProducts + soldProducts
        }
        else if type == 1 {
            getBought()
            products = boughtProducts
        }
        else if type == 2 {
            getSold()
            products = soldProducts
        }
        self.productsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    //MARK: DatabaseHelper interaction methods
    func getBought() {
        UserDBHelper.getUser(email: (PFUser.current()?.email)!) { (error, user) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                let currUser = user!
                self.boughtProducts = currUser.purchasedProducts ?? []
            }
        }
    }
    
    
    func getSold() {
        TransactionsDBHelper.getRecentSoldProducts(limit: 40) { (error, products) in
            if let error = error {
                print(error.localizedDescription)
            } else if products != nil {
                self.soldProducts = products ?? []
            }
        }
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            getProducts(_type: 0)
        case 1:
            getProducts(_type: 1)
        case 2:
            getProducts(_type: 2)
        default:
            break
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsProductCell") as! TransactionsProductCell
        
        if products[indexPath.row].picture != nil {
            let productImageFile = products[indexPath.row].picture
            productImageFile!.getDataInBackground { (imageData: Data?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.productImageView.image = image
                }
                
            }
        }
            
        cell.productNameLabel.text = products[indexPath.row].name
        cell.blurbLabel.text = products[indexPath.row].blurb
        cell.priceLabel.text = String(format: "$%.02f", products[indexPath.row].price)
        
        return cell
    }

    
}
