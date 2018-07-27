//
//  ProductDetailViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 17/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper
import SDWebImage
import JGProgressHUD

class ProductDetailViewController: ViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var innerScrollView: UIScrollView!
    
    var innerView: InnerView!
    var innerBottomView: InnerBottomView!
    
    var productId: Int
    var productName: String

    init(productId: Int, productName: String) {
        self.productId = productId
        self.productName = productName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.addToBasketButton.layer.cornerRadius = 15
//        
//        self.stepper.layer.cornerRadius = 15
//        self.stepper.layer.borderWidth = 1
//        self.stepper.layer.borderColor = UIColor.gray.cgColor
//        self.stepper.buttonsBackgroundColor = UIColor.white
//        self.stepper.buttonsTextColor = UIColor.gray
//        self.stepper.labelBackgroundColor = UIColor.white
//        self.stepper.labelTextColor = UIColor.black
        // Do any additional setup after loading the view.
        
//        self.innerScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height)
        
        self.view.layoutIfNeeded()
        
        self.innerView = InnerView(frame: CGRect(origin: CGPoint(x: 0, y: 275), size: CGSize(width: UIScreen.main.bounds.size.width - 40, height: 760)))
        self.innerView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        self.innerView.layoutIfNeeded()
        self.innerView.delegate = self
//        self.innerView.translatesAutoresizingMaskIntoConstraints = false
        
//        var constX:NSLayoutConstraint = NSLayoutConstraint(item: new_view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
        
//        self.innerView.addConstraint(NSLayoutConstraint(item: self, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: self., attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
        
        
        self.innerScrollView.addSubview(self.innerView)
        
        self.innerView.addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: UIControlEvents.touchUpInside)
        self.innerView.addToBasketButton.setBackgroundColor(UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1), for: UIControlState.selected)
        self.innerView.addToBasketButton.clipsToBounds = true
        
        self.innerBottomView = InnerBottomView(frame: CGRect(origin: CGPoint(x: 0, y : self.innerView.frame.size.height + 390), size: CGSize(width: self.innerScrollView.frame.size.width, height: 400)))
        self.innerBottomView.layoutIfNeeded()
        self.innerBottomView.delegate = self
        
        self.innerScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 760 + 275 + 64)
        
        print("self.innerScrollView.contentSize: \(self.innerScrollView.contentSize)")
        print("before self.innerView.addToHealthAppButton.frame.origin.y: \(self.innerView.addToHealthAppButton.frame.origin.y)")
        
        self.fetchProductDetail()
        
//        self.innerView.sizeToFit()
        
        print("after self.innerView.addToHealthAppButton.frame.origin.y: \(self.innerView.addToHealthAppButton.frame.origin.y)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.title = self.productName
        
        self.leftBackButton()
        self.rightShareButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftItemClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightItemClicked() {
        print("share button clicked")
    }
    
    func fetchProductDetail() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.backgroundColor = UIColor.white
        
        NetworkManager.shared().fetchProductDetail(productId: self.productId, completionHandler: { response in
            
            self.productImage?.sd_setImage(with: URL(string: response.images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in
                
                self.productImage?.image = AppManager.shared().resizeImage(image: image!, newWidth: 375)
            }
            self.innerView.nutritionsArray = response.nutritionalValues!
            self.innerView.shortDescription.text = response.shortDescription
            self.innerView.productPrice.text = "\(response.price!)" + " TL"
            self.innerView.productInformation.text = response.productDescription
            self.innerView.aboutManufacturer.text = response.aboutManufacturer
            self.innerView.nutritionTableView.reloadData()
            hud.dismiss()
        })
    }
    
    @objc func addToBasketButtonTapped() {
        if self.innerView.stepper.value != 0 {
            self.innerView.addToBasketButton.isSelected = !self.innerView.addToBasketButton.isSelected
            
            if self.innerView.addToBasketButton.isSelected {
                self.innerView.addToBasketButton.setTitle("✓ \(Int(self.innerView.stepper.value)) ADET SEPETTE", for: UIControlState.selected)
            }
            else {
                self.innerView.addToBasketButton.setTitle("SEPETE EKLE", for: UIControlState.selected)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
