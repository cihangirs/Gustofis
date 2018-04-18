//
//  InnerView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper

class InnerView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var addToHealthAppButton: UIButton!
    
    @IBOutlet weak var stepper: GMStepper!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InnerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.addToHealthAppButton.layer.cornerRadius = 17.5
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
    
}
