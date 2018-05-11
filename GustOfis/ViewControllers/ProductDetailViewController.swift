//
//  ProductDetailViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 17/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import GMStepper
import JGProgressHUD
import SDWebImage

class ProductDetailViewController: ViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var innerScrollView: UIScrollView!
    //@IBOutlet weak var innerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var addToHealthAppButton: UIButton!
    
    var innerView: InnerView!
    
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
        
        self.innerScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 760 + 275)
        
        self.view.layoutIfNeeded()
        
        self.innerView = InnerView(frame: CGRect(origin: CGPoint(x: 0,y :275), size: CGSize(width: UIScreen.main.bounds.size.width - 40, height: self.innerScrollView.contentSize.height - 275)))
        self.innerView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        self.innerView.layoutIfNeeded()
        
        self.innerScrollView.addSubview(self.innerView)
        
        self.fetchProductDetail()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.title = self.productName
        
        self.leftCloseButton()
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
        
        NetworkManager.shared().fetchProductDetail(productId: self.productId, completionHandler: { response in
            
            self.productImage?.sd_setImage(with: URL(string: response.images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in
                
                self.productImage?.image = AppManager.shared().resizeImage(image: image!, newWidth: 375)
            }
            
            self.innerView.shortDescription.text = response.shortDescription
            self.innerView.productPrice.text = response.price! + " TL"
            self.innerView.productInformation.text = response.productDescription
            self.innerView.aboutManufacturer.text = response.aboutManufacturer
            hud.dismiss()
        })
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
