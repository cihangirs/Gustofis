//
//  SecondViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD

class SecondViewController: ViewController {

    @IBOutlet weak var myTextView: UITextView!
    
    var categorieArray = [Categorie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().fetchCategories(completionHandler: { categorieArray in
            
            self.myTextView.text.removeAll()
            
            self.categorieArray = categorieArray;
            
            for categorie in self.categorieArray
            {
                self.myTextView.text.append("categorieId: \(categorie.categorieId!) categorieName: \(categorie.name!)\n")
                print("categorieId: \(categorie.categorieId!) parentId: \(categorie.name!)\n")
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
