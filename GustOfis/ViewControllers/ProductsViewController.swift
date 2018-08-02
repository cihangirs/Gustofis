//
//  ExclusivesViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 13/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD
import Segmentio
import SDWebImage

class ProductsViewController: ViewController, UITableViewDelegate, UITableViewDataSource, CartOperationsDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var basketCount: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    //weak var delegate: HomeViewController?
    weak var appDelegate: AppDelegate?
    
    var productArray = [Product]()
    var content = [SegmentioItem]()
    var stock: Stock?
    var previousSelectedCategoryCell: CategoryCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchStock(0)
        
        //self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        self.view.backgroundColor = UIColor.clear
        self.basketButton.layer.cornerRadius = 31.5
        
        self.productsTableView.estimatedRowHeight = 375
        self.productsTableView.rowHeight = UITableViewAutomaticDimension
        
        self.productsTableView.register(UINib(nibName: "ProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //self.categoryCollectionView.setCollectionViewLayout(layout, animated: false)
        //self.segmentioView.isHidden = true
        self.productsTableView.isHidden = true
        self.basketButton.isHidden = true
        self.basketCount.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filterMenuIcon.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightItemClicked))
        
        self.productsTableView.reloadData()
    }

// MARK: - action methods
    
    @IBAction func didBasketButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }

// MARK: - collectionView delegate methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.stock != nil {
            return (self.stock?.categories?.count)!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CategoryCollectionViewCell
        
        let categorie: Categorie = (self.stock?.categories![indexPath.row])!
        
        let url = URL(string: categorie.iconNormal!)
        if let data = try? Data(contentsOf: url!)
        {
            let image: UIImage = UIImage(data: data)!

            //cell.categoryImageView.image = image

            cell.categoryButton.setBackgroundImage(image, for: UIControlState.normal)
            
            let url2 = URL(string: categorie.iconActive!)
            if let data2 = try? Data(contentsOf: url2!)
            {
                let image2: UIImage = UIImage(data: data2)!

                cell.categoryButton.setBackgroundImage(image2, for: UIControlState.selected)
            }
        }

        cell.categoryLabel.text = categorie.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        previousSelectedCategoryCell?.categoryButton.isSelected = false
        
        let categorieCell: CategoryCollectionViewCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        categorieCell.categoryButton.isSelected = !categorieCell.categoryButton.isSelected
        
        previousSelectedCategoryCell = categorieCell
        
        let subCategoryViewController = SubCategoryViewController()
        subCategoryViewController.categorieId = self.stock!.categories![indexPath.row].categorieId!
        subCategoryViewController.title = self.stock!.categories![indexPath.row].name
        self.navigationController?.pushViewController(subCategoryViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
// MARK: - tableView delegate methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ProductsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.delegate = self
        cell.product = self.stock?.products![indexPath.section]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductDetailViewController(productId: (self.stock?.products![indexPath.section].productId)!, productName: (self.stock?.products![indexPath.section].name)!), animated: true)
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
        //headerView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

// MARK: - network calls
    
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
        
        NetworkManager.shared().updateCart(productId: productId, quantity: quantity) { cart in
            print("cart: \(cart)")
            self.basketCount.text = "\(cart.itemCount!)"
            self.basketButton.isHidden = false
            self.basketCount.isHidden = false
            hud.dismiss()
        }
    }

    func fetchStock(_ categorieId: Int) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().fetchStock(categorieId: categorieId) { stock in
            self.stock = stock
            self.categoryCollectionView.contentSize = CGSize(width: (self.stock?.categories?.count)! * 100, height: 130)
                //CGSizeMake(self.view.frame.size.width, (numberOfRows * heightOfCell));
            //self.showCategories((self.stock?.categories)!)
            self.productsTableView.reloadData()
            self.categoryCollectionView.reloadData()
            
            //self.segmentioView.isHidden = false
            self.productsTableView.isHidden = false

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
            
            hud.dismiss()
        }
    }

    func showCategories(_ categorieArray: [Categorie]) {
        
        self.content.removeAll()
        
        for categorie in categorieArray
        {
            let url = URL(string: categorie.iconNormal!)
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data)!
                
                let url2 = URL(string: categorie.iconActive!)
                if let data2 = try? Data(contentsOf: url2!)
                {
                    let image2: UIImage = UIImage(data: data2)!
                    
                    var categorieItem = SegmentioItem(
                        title: categorie.name,
                        image: AppManager.shared().resizeImage(image: image, newWidth: 65)
                    )
                
                    categorieItem.selectedImage = AppManager.shared().resizeImage(image: image2, newWidth: 65)
                    
                    self.content.append(categorieItem)
                }
            }
            
        }
        
        self.segmentioView.setup(
            content: self.content,
            style: SegmentioStyle.imageOverLabel,
            options: SegmentioOptions(backgroundColor: UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0), segmentPosition: .fixed(maxVisibleItems: 3), scrollEnabled: true,
                                      indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: .clear), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                                        type: SegmentioHorizontalSeparatorType.none, // Top, Bottom, TopAndBottom
                                        height: 1,
                                        color: .gray
                ), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0.6, // from 0.1 to 1
                    color: .clear
                ), imageContentMode: .bottom, labelTextAlignment: .center, labelTextNumberOfLines: 2, segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "ProximaNova-Semibold", size: 14)!,//UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: UIColor(red: 59/255, green: 53/255, blue: 55/255, alpha: 1.0) //.black
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "ProximaNova-Semibold", size: 14)!,
                        titleTextColor: UIColor(red: 59/255, green: 53/255, blue: 55/255, alpha: 1.0)
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: .clear, //UIColor.lightGray.withAlphaComponent(0.6),
                        titleFont: UIFont(name: "ProximaNova-Semibold", size: 14)!,
                        titleTextColor: UIColor(red: 59/255, green: 53/255, blue: 55/255, alpha: 1.0)
                    )
            ), animationDuration: 0.1)
        )
        
        self.segmentioView.valueDidChange = { segmentio, segmentIndex in
            let subCategoryViewController = SubCategoryViewController()
            subCategoryViewController.categorieId = self.stock!.categories![segmentIndex].categorieId!
            subCategoryViewController.title = self.stock!.categories![segmentIndex].name
            print("selectedSegmentioIndex: \(self.segmentioView.selectedSegmentioIndex)")
            self.navigationController?.pushViewController(subCategoryViewController, animated: true)
            //self.fetchStock((self.stock?.categories![segmentIndex].categorieId)!)
        }
    }
}
