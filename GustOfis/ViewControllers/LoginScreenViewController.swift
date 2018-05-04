//
//  LoginScreenViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class LoginScreenViewController: ViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var gustofisLogo: UIImageView!
    @IBOutlet weak var gustofisLogoTopConstraint: NSLayoutConstraint!
    
    var isTextFieldsSetDefault: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isTextFieldsSetDefault = false
        
        self.email.setDefaults(placeholderText: "E-posta adresi", borderLineWidth: 261)
        self.password.setDefaults(placeholderText: "Şifre", borderLineWidth: 261)
        
        self.loginButton.layer.cornerRadius = 17.5
        self.loginButton.layer.borderWidth = 0.5
        self.loginButton.layer.borderColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0).cgColor
        self.registerButton.layer.cornerRadius = 17.5
        self.facebookButton.layer.cornerRadius = 17.5
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        print("\(UIScreen.main.bounds.size.width) : \(UIScreen.main.bounds.size.height)")
        
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:867)

        print("before: \(self.gustofisLogoTopConstraint.constant)")
        
        self.gustofisLogoTopConstraint.constant = -((self.email.frame.origin.y - self.gustofisLogo.frame.size.height) / 2)
        
        print("after: \(self.gustofisLogoTopConstraint.constant)")
        
        self.view.layoutIfNeeded()
        
        if !self.isTextFieldsSetDefault {
            self.isTextFieldsSetDefault = !self.isTextFieldsSetDefault
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        
        self.textfield = textField
        self.textfield.becomeFirstResponder()
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("hello \(self.email.text!) your password is \(self.password.text!)")
        self.textfield.resignFirstResponder()
        print("isValidEmail: \(self.email.text!.isValidEmail())")
        NetworkManager.shared().login(user: AppManager.shared().currentUser, completionHandler: { response in
            print("loginResponse: \(response)")
        })
        print("you logged in dude")
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(NewMemberViewController(), animated: true)
    }
    
    @IBAction func didFacebookButtonTapped(_ sender: UIButton) {
        print("didFacebookButtonTapped")
    }

}
