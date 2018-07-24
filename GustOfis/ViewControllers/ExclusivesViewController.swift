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

class ExclusivesViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var exclusiveTableView: UITableView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var segmentioView: Segmentio!
    
    //weak var delegate: HomeViewController?
    weak var delegate: AppDelegate?
    
    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
    
        var content = [SegmentioItem]()
        
        for var i in 0..<10
        {
            let tornadoItem = SegmentioItem(
                title: "Category \(i)",
                image: UIImage(named: "headerLogo")
            )
            
            content.append(tornadoItem)
        }
        
        segmentioView.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: SegmentioOptions(backgroundColor: .clear, segmentPosition: .dynamic, scrollEnabled: true,
                                      indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: .orange), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                type: SegmentioHorizontalSeparatorType.none, // Top, Bottom, TopAndBottom
                height: 1,
                color: .gray
                ), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0.6, // from 0.1 to 1
                    color: .clear
                ), imageContentMode: .bottom, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .black
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .orange,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .white
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                        titleFont: UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .black
                    )
            ), animationDuration: 0.1)
        )

        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
        }
        
        self.basketButton.layer.cornerRadius = 31.5
        
        self.exclusiveTableView.estimatedRowHeight = 500
        self.exclusiveTableView.rowHeight = UITableViewAutomaticDimension
        
        self.exclusiveTableView.register(UINib(nibName: "ExclusiveTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.fetchProducts()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "headerLogo.png"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "locationArrow.png"), style: UIBarButtonItemStyle.done, target: self, action: #selector(rightItemClicked))
        //self.title = "some title"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightItemClicked() {
        self.delegate?.openFiltersView()
    }
    
    @IBAction func didBasketButtonTapped(_ sender: UIButton) {
        //self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        //print("didBasketButtonTapped")
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ExclusiveTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.delegate = self
        cell.product = self.productArray[indexPath.section]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductDetailViewController(productId: self.productArray[indexPath.row].productId!, productName: self.productArray[indexPath.row].name!), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productArray.count
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
            hud.dismiss()
        }
    }

    func fetchProducts() {

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)

        NetworkManager.shared().fetchProducts(completionHandler: { productArray in
            self.productArray = productArray;
            self.exclusiveTableView.reloadData()
            //            for product in self.productArray
            //            {
            //                //self.myTextView.text.append("productId: \(product.productId!) productName: \(product.name!)\n")
            //                print("productId: \(product.productId!) productName: \(product.name!)\n")
            //            }

            hud.dismiss()
        })
    }
    
}
