//
//  ProductCell.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/18/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func onBuyTap(cell: ProductCell)
    func onFavoriteTap(cell: ProductCell)
}

class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productBlurb: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFavoriteTap(_ sender: Any) {
        delegate?.onFavoriteTap(cell: self)
    }
    
    @IBAction func onBuyTap(_ sender: Any) {
        delegate?.onBuyTap(cell: self)
    }
}
