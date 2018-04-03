//
//  ThirdViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD

class ThirdViewController: ViewController {

    @IBOutlet weak var myTextView: UITextView!

    var productArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().fetchProducts(completionHandler: { productArray in
            
            self.myTextView.text.removeAll()
            
            self.productArray = productArray;
            
            for product in self.productArray
            {
                self.myTextView.text.append("productId: \(product.productId!) productName: \(product.name!)\n")
                print("productId: \(product.productId!) productName: \(product.name!)\n")
            }
            
            hud.dismiss()
        })
        // Do any additional setup after loading the view.
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
