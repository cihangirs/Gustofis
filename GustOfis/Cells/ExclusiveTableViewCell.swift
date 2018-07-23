//
//  ExclusiveTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 16/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper
import SDWebImage

class ExclusiveTableViewCell: UITableViewCell {

    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    weak var delegate: ExclusivesViewController?
    
    private var _product: Product? = nil
    
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

        self.addToBasketButton.layer.cornerRadius = 12
        self.addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: UIControlEvents.touchUpInside)
        self.addToBasketButton.setBackgroundColor(UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1), for: UIControlState.selected)
        self.addToBasketButton.clipsToBounds = true
    }

    var product: Product? {
        get {
            return self._product
        }
        set {
            self._product = newValue
            self.productName.text = self._product!.name
            self.productPrice.text = "\(self._product!.price!)" + " TL"
            self.productShortDescription.text = self._product!.shortDescription
            
            self.productImageView?.sd_setImage(with: URL(string: self._product!.images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in
                
                self.productImageView?.image = AppManager.shared().resizeImage(image: image!, newWidth: 1080)
            }
            
        }
    }
    
    @objc func addToBasketButtonTapped() {
        if self.stepper.value != 0 {
            self.addToBasketButton.isSelected = !self.addToBasketButton.isSelected
            
            if self.addToBasketButton.isSelected {
                self.delegate?.addToCart((self.product?.productId)!, Int(self.stepper.value))
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
