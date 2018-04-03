//
//  FirstViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class FirstViewController: ViewController {

    @IBOutlet weak var myTextView: UITextView!
    
    var orderArray = [Order]()
    
//    let arrayCompletionHandler: ([Order]) -> Void = {
//        print("declaredCompletionHandler: \($0)")
//        var orderArray = $0
//
//        //        var orderArray = [Order]()
//        //        orderArray.append(contentsOf: $0)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        NetworkManager.shared().fetchOrders(completionHandler: { orderArray in
            self.orderArray = orderArray
            myTextView.text = self.orderArray
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
