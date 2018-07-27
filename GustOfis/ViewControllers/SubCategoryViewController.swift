//
//  SubCategoryViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 24.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD
import Segmentio

class SubCategoryViewController: ViewController, UITableViewDelegate, UITableViewDataSource, CartOperationsDelegate {

    @IBOutlet weak var subCategoryTableView: UITableView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var basketCount: UILabel!
    
    var content = [SegmentioItem]()
    var stock: Stock?
    var categorieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.fetchStock(self.categorieId!)
        
        self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        
        self.basketButton.layer.cornerRadius = 31.5
        
        self.subCategoryTableView.estimatedRowHeight = 475
        self.subCategoryTableView.rowHeight = UITableViewAutomaticDimension
        
        self.subCategoryTableView.register(UINib(nibName: "ExclusiveTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filterMenuIcon.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(rightItemClicked))

        if let returnValue = UserDefaults.standard.object(forKey: "basketCount") as? Int {
            if returnValue == 0 {
                self.basketCount.isHidden = true
                self.basketButton.isHidden = true
            }
            else {
                self.basketCount.text = "\(returnValue)"
                self.basketCount.isHidden = false
                self.basketButton.isHidden = false
            }
        } else {
            self.basketCount.isHidden = true
            self.basketButton.isHidden = true
        }
        
        self.leftBackButton()
    }

    override func leftItemClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didBasketButtonTapped(_ sender: Any) {
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ExclusiveTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.delegate = self
        cell.product = self.stock?.products![indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductDetailViewController(productId: (self.stock?.products![indexPath.row].productId)!, productName: (self.stock?.products![indexPath.row].name)!), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.stock != nil {
            return (self.stock?.products?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
 
    func addToCart(_ productId: Int, _ quantity: Int){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().addToCart(productId: productId, quantity: quantity) { addToCartResponse in
            print("addToCartResponse: \(addToCartResponse)")
            self.basketCount.text = "\(addToCartResponse.itemCount!)"
            self.basketButton.isHidden = false
            self.basketCount.isHidden = false
            hud.dismiss()
        }
    }

    func updateCart(_ productId: Int, _ quantity: Int){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().updateCart(productId: productId, quantity: quantity) { updateCartResponse in
            print("updateCartResponse: \(updateCartResponse)")
            self.basketCount.text = "\(updateCartResponse.itemCount!)"
            self.basketButton.isHidden = false
            self.basketCount.isHidden = false
            hud.dismiss()
        }
    }

    
    func fetchStock(_ categorieId: Int) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.backgroundColor = UIColor.white
        
        NetworkManager.shared().fetchStock(categorieId: categorieId) { stock in
            print("stock: \(stock)")
            self.stock = stock
            
            self.showCategories((self.stock?.categories)!)
            self.subCategoryTableView.reloadData()
            hud.dismiss()
        }
    }
    
    func fetchSubCategorieStock(_ categorieId: Int) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().fetchStock(categorieId: categorieId) { stock in
            print("stock: \(stock)")
            self.stock?.products = stock.products
            self.subCategoryTableView.reloadData()
            hud.dismiss()
        }
    }

    func showCategories(_ categorieArray: [Categorie]) {
        
        self.content.removeAll()
        
        for categorie in categorieArray
        {
            let categorieItem = SegmentioItem(
                title: categorie.name,
                image: nil
            )
            
            self.content.append(categorieItem)
        }
        
        self.segmentioView.setup(
            content: self.content,
            style: SegmentioStyle.onlyLabel,
            options: SegmentioOptions(backgroundColor: .clear, segmentPosition: .fixed(maxVisibleItems: 3), scrollEnabled: true,
                                      indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 2, color: UIColor(red: 153/255, green: 204/255, blue: 0, alpha: 1.0)), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                                        type: SegmentioHorizontalSeparatorType.none, // Top, Bottom, TopAndBottom
                                        height: 1,
                                        color: .gray
                ), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0.6, // from 0.1 to 1
                    color: .clear
                ), imageContentMode: .bottom, labelTextAlignment: .center, labelTextNumberOfLines: 2, segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "ProximaNova-Regular", size: 15)!,//UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: UIColor(red: 42/255, green: 43/255, blue: 51/255, alpha: 1.0) //.black
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "ProximaNova-Semibold", size: 15)!,
                        titleTextColor: UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "ProximaNova-Semibold", size: 15)!,
                        titleTextColor: UIColor(red: 153/255, green: 204/255, blue: 0/255, alpha: 1.0)
                    )
            ), animationDuration: 0.1)
        )
        
        self.segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            print("self.categorieId: \(self.stock!.categories![segmentIndex].categorieId!)")
            self.title = self.stock!.categories![segmentIndex].name
            self.fetchSubCategorieStock(self.stock!.categories![segmentIndex].categorieId!)
            //self.fetchStock(self.categorieId!)
            //self.navigationController?.pushViewController(SubCategoryViewController(), animated: true)
            //self.fetchStock((self.stock?.categories![segmentIndex].categorieId)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
