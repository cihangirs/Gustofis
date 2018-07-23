//
//  CartTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartItemCountTF: UITextField!
    @IBOutlet weak var cartItemName: UILabel!
    @IBOutlet weak var cartItemIngredients: UILabel!
    @IBOutlet weak var cartItemPrice: UILabel!

    weak var delegate: CartViewController?
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
