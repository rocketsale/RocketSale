//
//  FavoritesCell.swift
//  RocketSale
//
//  Created by Ryan M on 5/27/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

protocol FavoritesCellDelegate: AnyObject {
    func onBuyButton(cell: FavoritesCell)
}

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    weak var delegate: FavoritesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onBuyButton(_ sender: Any) {
        delegate?.onBuyButton(cell: self)
    }
}
