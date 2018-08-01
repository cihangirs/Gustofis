//
//  ExclusiveTableViewCell.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 16/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import SDWebImage

protocol CartOperationsDelegate: class {
    func addToCart(_ productId: Int, _ quantity: Int)
    func updateCart(_ productId: Int, _ quantity: Int)
    // Protocol stuff goes here
}

class ProductsTableViewCell: UITableViewCell, GustStepperDelegate {
    
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var stepper: GustStepper!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var basketImage: UIImageView!
    
    weak var delegate: CartOperationsDelegate?
    
    private var _product: Product? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.stepper.delegate = self
        self.stepper._stepperCount = 1

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
            self.productShortDescription.text = self._product!.shortDescription
            
            self.productImageView?.sd_setImage(with: URL(string: self._product!.images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

                if image != nil
                {
                    self.productImageView?.image = AppManager.shared().resizeImage(image: image!, newWidth: 1080)
                }
            }
            
            self.addToBasketButton.isHidden = (self._product!.inCart)!
            self.basketImage.isHidden = self.addToBasketButton.isHidden
            
            self.stepper.isHidden = !self.addToBasketButton.isHidden

            if (self._product?.inCart)! {
                print("self._product?.quantityInTheCart: \(self._product!.quantityInTheCart!)")
                self.stepper._stepperCount = (self._product?.quantityInTheCart)!
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func didAddToBasketButtonTapped(_ sender: UIButton) {
        sender.isHidden = true
        self.basketImage.isHidden = true
        self.stepper._stepperCount = 1
        self.stepper.isHidden = false
        self._product?.inCart = true
        self._product?.quantityInTheCart = 1
        self.delegate?.addToCart((self.product?.productId)!, 1)
    }

    func didStepperCountChanged(value: Int) {
        print("didStepperCountChanged with \(value)")
        self._product?.quantityInTheCart = self.stepper._stepperCount
        self.delegate?.updateCart((self.product?.productId)!, Int(self.stepper.stepperCount))
    }
    
}
