//
//  ExclusivesViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 13/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import SDWebImage

class ExclusivesViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var exclusiveTableView: UITableView!
    @IBOutlet weak var basketButton: UIButton!
    
    weak var delegate: HomeViewController?
    
    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
    
        self.basketButton.layer.cornerRadius = 31.5
        
        self.exclusiveTableView.estimatedRowHeight = 500
        self.exclusiveTableView.rowHeight = UITableViewAutomaticDimension
        
        self.exclusiveTableView.register(UINib(nibName: "ExclusiveTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didBasketButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        //print("didBasketButtonTapped")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ExclusiveTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.productName.text = self.productArray[indexPath.section].name
        cell.productPrice.text = "\(self.productArray[indexPath.section].price!)" + " TL"
        cell.productShortDescription.text = self.productArray[indexPath.section].shortDescription

        cell.productImageView?.sd_setImage(with: URL(string: self.productArray[indexPath.section].images![0].src!), placeholderImage: nil){ (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

            cell.productImageView?.image = AppManager.shared().resizeImage(image: image!, newWidth: 1080)
        }
        
        print("src: \(self.productArray[indexPath.section].images![0].src!)")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("productId: \(self.productArray[indexPath.row].productId!)")
//        self.navigationController?.pushViewController(ProductDetailViewController(productId: self.productArray[indexPath.row].productId!, productName: self.productArray[indexPath.row].name!), animated: true)
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

}
