//
//  DetailedProductViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

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
        setProductImage(picture: product.picture, imageView: productImageView)
        setProductPurchasedStatus(product: product, button: productBuyButton)
    }
    
    func setProductImage(picture: PFFileObject?, imageView: UIImageView) {
        if picture != nil {
            let urlString = product.picture!.url!
            let url = URL(string: urlString)
            imageView.af_setImage(withURL: url!)
        }
    }
    
    func setProductPurchasedStatus(product: Product, button: UIButton) {
        if product.isPurchased {
            productBuyButton.isHidden = true
        }
    }
    
    //MARK: Style related methods
    func setStyles() {
        roundView(view: productImageView, option: "rounded")
        roundView(view: productBuyButton, option: "default")
        roundView(view: productDetailsView, option: "default")
        productImageView.layer.borderWidth = 2
        productImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: Database interaction methods
    func purchaseProduct(product: Product) {
        ProductDBHelper.purchaseProduct(product: product) { (error, product) in
            if error != nil {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not purchase product", viewController: self)
            } else if product != nil{
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
