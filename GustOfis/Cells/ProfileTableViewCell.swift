//
//  ProfileTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 10.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileMenuLabel: UILabel!
    @IBOutlet weak var profileMenuIW: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
