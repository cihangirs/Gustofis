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
    @IBOutlet weak var productImageView: UIImageView!
    
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
        self.addToBasketButton.layer.cornerRadius = 12
        self.addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: UIControlEvents.touchUpInside)
        self.addToBasketButton.setBackgroundColor(UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1), for: UIControlState.selected)
        self.addToBasketButton.clipsToBounds = true
//        let centerConstraint = NSLayoutConstraint(item: imageView!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)

//        imageView?.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addConstraint(centerConstraint)
    }

    @objc func addToBasketButtonTapped() {
        if self.stepper.value != 0 {
            self.addToBasketButton.isSelected = !self.addToBasketButton.isSelected
            
            if self.addToBasketButton.isSelected {
                self.addToBasketButton.setTitle("✓ \(Int(self.stepper.value)) ADET SEPETTE", for: UIControlState.selected)
            }
            else {
                self.addToBasketButton.setTitle("SEPETE EKLE", for: UIControlState.selected)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didAddToBasketButtonTapped(_ sender: UIButton) {
        print("didAddToBasketButtonTapped with stepper value:\(stepper.value)")
    }
    
    
}
