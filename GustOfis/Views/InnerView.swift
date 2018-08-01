//
//  InnerView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class InnerView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var addToHealthAppButton: UIButton!
    
    //@IBOutlet weak var stepper: GMStepper!
    
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productInformation: UILabel!
    @IBOutlet weak var aboutManufacturer: UILabel!
    
    @IBOutlet weak var nutritionTableView: UITableView!
    @IBOutlet weak var nutritionTableViewHeightConstraint: NSLayoutConstraint!
    
    var nutritionsArray = [Nutrition]()
    weak var delegate: ProductDetailViewController?
    
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
        
        self.nutritionTableView.register(UINib(nibName: "NutritionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.nutritionTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.addToHealthAppButton.layer.cornerRadius = 17.5
        self.addToBasketButton.layer.cornerRadius = 12

//        self.stepper.layer.cornerRadius = 12
//        self.stepper.layer.borderWidth = 1
//        self.stepper.layer.borderColor = UIColor.gray.cgColor
//        self.stepper.buttonsBackgroundColor = UIColor.white
//        self.stepper.buttonsTextColor = UIColor.gray
//        self.stepper.labelBackgroundColor = UIColor.white
//        self.stepper.labelTextColor = UIColor.black
//        self.stepper.labelFont = UIFont(name: "ProximaNova-Semibold", size: 15.0)!
//        self.stepper.labelTextColor = UIColor(red: 72/255, green: 70/255, blue: 70/255, alpha: 1)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nutritionsArray.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NutritionTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.nutritionName.text = self.nutritionsArray[indexPath.row].name
        cell.nutritionValue.text = self.nutritionsArray[indexPath.row].value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.nutritionTableView.layer.removeAllAnimations()
        
        self.frame.size.height = self.addToHealthAppButton.frame.maxY
        
        UIView.animate(withDuration: 0.5) {
            self.updateConstraints()
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func didAddToBasketButtonTapped(_ sender: UIButton) {
        //print("didAddToBasketButtonTapped with stepper value:\(stepper.value)")
    }
    
    @IBAction func didAddToHealthAppButtonTapped(_ sender: UIButton) {
        print("didAddToHealthAppButtonTapped")
    }
}
