//
//  GoesWellByTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 15.05.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper

class GoesWellByTableViewCell: UITableViewCell {

    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.stepper.layer.cornerRadius = 12
        self.stepper.layer.borderWidth = 1
        self.stepper.layer.borderColor = UIColor.gray.cgColor
        self.stepper.buttonsBackgroundColor = UIColor.white
        self.stepper.buttonsTextColor = UIColor.gray
        self.stepper.labelBackgroundColor = UIColor.white
        self.stepper.labelTextColor = UIColor.black
        self.stepper.labelFont = UIFont(name: "ProximaNova-Semibold", size: 15.0)!
        self.stepper.labelTextColor = UIColor(red: 72/255, green: 70/255, blue: 70/255, alpha: 1)
        
        //        self.addToBasketButton.setTitle("SEPETE EKLE", for: UIControlState.normal)
        //        self.addToBasketButton.setTitle("hehehehh", for: UIControlState.selected)
        self.purchaseButton.layer.cornerRadius = 12
        self.purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: UIControlEvents.touchUpInside)
        self.purchaseButton.setBackgroundColor(UIColor(red: 219/255, green: 36/255, blue: 58/255, alpha: 1), for: UIControlState.selected)
        self.purchaseButton.clipsToBounds = true
    }

    @objc func purchaseButtonTapped() {
//        if self.stepper.value != 0 {
//            self.addToBasketButton.isSelected = !self.addToBasketButton.isSelected
//
//            if self.addToBasketButton.isSelected {
//                self.addToBasketButton.setTitle("✓ \(Int(self.stepper.value)) ADET SEPETTE", for: UIControlState.selected)
//            }
//            else {
//                self.addToBasketButton.setTitle("SEPETE EKLE", for: UIControlState.selected)
//            }
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
