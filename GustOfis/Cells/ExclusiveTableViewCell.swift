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

protocol CartOperationsDelegate: class {
    func addToCart(_ productId: Int, _ quantity: Int)
    func updateCart(_ productId: Int, _ quantity: Int)
    // Protocol stuff goes here
}

class ExclusiveTableViewCell: UITableViewCell {

    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var basketImage: UIImageView!
    
    weak var delegate: CartOperationsDelegate?
    
    private var _product: Product? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.stepper.minimumValue = 1
        self.stepper.layer.cornerRadius = 12
        self.stepper.layer.borderWidth = 1
        self.stepper.layer.borderColor = UIColor.clear.cgColor
        self.stepper.buttonsBackgroundColor = UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
        self.stepper.buttonsTextColor = UIColor.white
        self.stepper.labelBackgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.stepper.labelTextColor = UIColor(red: 59/255, green: 53/255, blue: 55/255, alpha: 1)
        self.stepper.labelFont = UIFont(name: "ProximaNova-Semibold", size: 13.0)!
        self.stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)

        self.addToBasketButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        self.addToBasketButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 35)
        //self.addToBasketButton.layer.cornerRadius = 10
        //self.addToBasketButton.setBackgroundColor(UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1), for: UIControlState.selected)
        //self.addToBasketButton.clipsToBounds = true
    }

    var product: Product? {
        get {
            return self._product
        }
        set {
            self._product = newValue
            self.productName.text = self._product!.name
            
            self.addToBasketButton.setTitle("\(self._product!.price!) ₺", for: UIControlState.normal)
            //self.productPrice.text = "\(self._product!.price!)" + " TL"
            self.productShortDescription.text = self._product!.shortDescription
            
            self.productImageView?.sd_setImage(with: URL(string: self._product!.images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

                self.productImageView?.image = AppManager.shared().resizeImage(image: image!, newWidth: 1080)
            }
            
            self.addToBasketButton.isHidden = (self._product!.inCart)!
            self.stepper.isHidden = !self.addToBasketButton.isHidden
            self.basketImage.isHidden = self.addToBasketButton.isHidden
            
            if (self._product?.inCart)! {
                self.stepper.value = Double((self._product?.quantityInTheCart)!)
            }
        }
    }

    @objc func didStepperValueChanged() {
        if (Int(self.stepper.value) != self._product?.quantityInTheCart)
        {
            self.delegate?.updateCart((self.product?.productId)!, Int(self.stepper.value))
            self._product?.quantityInTheCart = Int(self.stepper.value)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didAddToBasketButtonTapped(_ sender: UIButton) {
        print("didAddToBasketButtonTapped with stepper value:\(stepper.value)")
        sender.isHidden = true
        self.basketImage.isHidden = true
        self.stepper.value = 1
        self.stepper.isHidden = false
        self._product?.inCart = true
        self._product?.quantityInTheCart = 1
        self.delegate?.addToCart((self.product?.productId)!, 1)
    }
    
    
}
