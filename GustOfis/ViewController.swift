//
//  ViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {

//    let firstViewController: FirstViewController?
//    let secondViewController: SecondViewController?
//    let thirdViewController: ThirdViewController?
//    let fourthViewController: FourthViewController?
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkManager.shared().fetchProducts()
//        NetworkManager.shared().fetchOrders()
//        NetworkManager.shared().fetchCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        //self.navigationController?.pushViewController(firstViewController, animated: true)
        
        switch item.tag {
            case 0:
                print("Selected item \(item.tag)")
            case 1:
                print("Selected item \(item.tag)")
            case 2:
                print("Selected item \(item.tag)")
            case 3:
                print("Selected item \(item.tag)")
            default:
                print("Selected item \(item.tag)")
        }
        
    }
}
