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
    weak var delegate: HomeViewController?
    
    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.exclusiveTableView.register(UINib(nibName: "ExclusiveTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

            cell.productImageView?.image = self.resizeImage(image: image!, newWidth: 240)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductDetailViewController(), animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
