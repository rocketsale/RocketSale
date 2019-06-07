//
//  ProductSwiperViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 6/6/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit
import Koloda

class ProductSwiperViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var products : [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.layer.cornerRadius = 20
        kolodaView.clipsToBounds = true
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    //MARK: Interactivity Methods for Koloda View
    @IBAction func onExitSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helper Methods
    func favoriteProduct(product: Product) {
        ProductDBHelper.favoriteProduct(product: product) { (error, product) in
            if error != nil {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not favorite product", viewController: self)
            } else if product != nil {
               BaseAlertController.displayDisappearingMessage(msg: "Favorited Product", timer: 0.15, viewController: self)
            }
        }
    }
    
    func unFavoriteProduct(product: Product) {
        FavoritesDBHelper.unFavoriteProduct(selectedProduct: product) { (error, product) in
            if error != nil {
                BaseAlertController.displayErrorMessage(errorMsg: "Error! Could not unfavorite product", viewController: self)
            } else if product != nil{
                BaseAlertController.displayDisappearingMessage(msg: "Un-Favorited Product", timer: 0.15, viewController: self)
            }
        }
    }
}

//MARK: Extension for Koloda View Delegate
extension ProductSwiperViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //TODO logic to the detailed page
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        let product = products?[index]
        switch (direction) {
            case .right:
                favoriteProduct(product: product!)
                return
            case .left:
                unFavoriteProduct(product: product!)
                return
            default:
                return
        }
    }
}

//MARK: Extension for Koloda View Data Source
extension ProductSwiperViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return products!.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let newUIView = UIView()
        newUIView.frame = kolodaView.bounds
        newUIView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: newUIView.frame.width, height: 30)
        label.text = products?[index].name
        label.textAlignment = .center
        let newImageView = UIImageView()
        newImageView.clipsToBounds = true
        newImageView.contentMode = .scaleAspectFill
        newImageView.frame = CGRect(x:0, y:31, width: newUIView.frame.width, height: newUIView.frame.height - 10)
        let picture = products?[index].picture
        if picture != nil {
            let urlString = picture!.url!
            let url = URL(string: urlString)
            newImageView.af_setImage(withURL: url!)
        }
        newUIView.addSubview(label)
        newUIView.addSubview(newImageView)
        return newUIView
    }
}
