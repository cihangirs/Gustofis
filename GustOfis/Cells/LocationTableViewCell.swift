//
//  LocationTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 11/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocationName(_ locationName: String){
        self.locationName.text = locationName
    }
    
}
