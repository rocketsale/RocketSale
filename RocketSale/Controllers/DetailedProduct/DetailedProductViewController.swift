//
//  DetailedProductViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailedProductViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDetailsView: UIView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productBlurbLabel: UILabel!
    @IBOutlet weak var productBuyButton: UIButton!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProductData()
        setStyles()
    }
    
    //MARK: Set data related methods
    func setProductData() {
        productNameLabel.text = product.name
        productPriceLabel.text = String(format: "$%.02f", product.price)
        productBlurbLabel.text = product.blurb
        
        if product.picture != nil {
            let urlString = product.picture!.url!
            let url = URL(string: urlString)
            productImageView.af_setImage(withURL: url!)
        }
        
        if product.isPurchased {
            productBuyButton.isHidden = true
        }
    }
    
    //MARK: Style related methods
    func setStyles() {
        roundView(view: productImageView, option: "rounded")
        roundView(view: productBuyButton, option: "default")
        roundView(view: productDetailsView, option: "default")
    }
    
    func roundView(view: UIView, option: String) {
        view.layer.masksToBounds = true
        switch(option) {
            case "default":
                view.layer.cornerRadius = 5
                return
            case "rounded":
                view.layer.cornerRadius = view.frame.height/2
                return
            default:
                return
        }
    }
    
    //MARK: Database interaction methods
    func purchaseProduct(product: Product) {
        ProductDBHelper.purchaseProduct(product: product) { (error, product) in
            if error != nil {
                print(error?.localizedDescription)
            } else if product != nil{
                print(product)
                self.product = product
                self.setProductData()
            }
        }
    }
    
    //MARK: Interactivity methods
    @IBAction func onBuyTap(_ sender: Any) {
        purchaseProduct(product: product)
    }
}
