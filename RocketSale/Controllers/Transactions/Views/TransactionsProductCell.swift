//
//  TransactionsProductCell.swift
//  RocketSale
//
//  Created by Ryan M on 5/28/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class TransactionsProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var blurbLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView(view: productImageView, option: "default")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
