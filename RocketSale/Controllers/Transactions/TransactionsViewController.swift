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
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var products: [Product] = []
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productsTableView.delegate = self
        productsTableView.dataSource = self
        setupRefreshControl()
        
        getPurchasedProducts()
    }
    
    //MARK: Data reload methods
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(getPurchasedProducts), for: .valueChanged)
        productsTableView.refreshControl = refreshControl
    }
    
    //MARK: DatabaseHelper interaction methods
    @objc func getPurchasedProducts() {
        UserDBHelper.getUser(email: (PFUser.current()?.email)!) { (error, user) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                let currUser = user!
                self.products = currUser.purchasedProducts ?? []
                
                self.productsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: CHANGE return products.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsProductCell") as! TransactionsProductCell
        return cell
    }

}
