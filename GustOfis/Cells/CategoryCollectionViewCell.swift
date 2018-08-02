//
//  CategoryCollectionViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 1.08.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.categoryButton.isUserInteractionEnabled = false
    }

}
