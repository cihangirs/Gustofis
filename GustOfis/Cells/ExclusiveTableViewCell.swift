//
//  ExclusiveTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 16/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper

class ExclusiveTableViewCell: UITableViewCell {

    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addToBasketButton.layer.cornerRadius = 12
        
        self.stepper.layer.cornerRadius = 12
        self.stepper.layer.borderWidth = 1
        self.stepper.layer.borderColor = UIColor.gray.cgColor
        self.stepper.buttonsBackgroundColor = UIColor.white
        self.stepper.buttonsTextColor = UIColor.gray
        self.stepper.labelBackgroundColor = UIColor.white
        self.stepper.labelTextColor = UIColor.black
        self.stepper.labelFont = UIFont(name: "ProximaNova-Semibold", size: 15.0)!
        self.stepper.labelTextColor = UIColor(red: 72/255, green: 70/255, blue: 70/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didAddToBasketButtonTapped(_ sender: UIButton) {
        print("didAddToBasketButtonTapped with stepper value:\(stepper.value)")
    }
    
    
}
