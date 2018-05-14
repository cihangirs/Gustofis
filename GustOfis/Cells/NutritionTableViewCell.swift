//
//  NutritionTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 14.05.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {

    @IBOutlet weak var nutritionName: UILabel!
    @IBOutlet weak var nutritionValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
