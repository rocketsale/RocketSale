//
//  FavoritesCell.swift
//  RocketSale
//
//  Created by Ryan M on 5/27/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

protocol FavoritesCellDelegate: class {
    func onBuyButton(cell: FavoritesCell)
    func onUnFavorite(cell: FavoritesCell)
}

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var unFavoriteButton: UIButton!
    
    weak var delegate: FavoritesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundButtonCorners()
        roundView(view: productImageView, option: "default")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: Styling methods
    func roundButtonCorners() {
        buyButton.layer.cornerRadius = 7
        buyButton.layer.masksToBounds = true
        unFavoriteButton.layer.cornerRadius = 7
        unFavoriteButton.layer.masksToBounds = true
    }

    @IBAction func onBuyButton(_ sender: Any) {
        delegate?.onBuyButton(cell: self)
    }
    
    @IBAction func onUnFavorite(_ sender: Any) {
        delegate?.onUnFavorite(cell: self)
    }
    
}
