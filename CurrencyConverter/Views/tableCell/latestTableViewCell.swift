//
//  latestTableViewCell.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/26/22.
//

import UIKit

class latestTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyKey: UILabel!
    
    @IBOutlet weak var currencyRate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
