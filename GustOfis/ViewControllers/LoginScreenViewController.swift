//
//  LoginScreenViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class LoginScreenViewController: ViewController {

    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("hello \(self.nameSurname.text!) your password is \(self.password.text!)")
        print("you logged in dude")
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
            print("registerButtonTapped")
        self.navigationController?.pushViewController(NewMemberViewController(), animated: true)
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
