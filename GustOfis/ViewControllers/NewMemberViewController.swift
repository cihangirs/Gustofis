//
//  NewMemberViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class NewMemberViewController: ViewController, SomeProtocol {
    
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var locationSelectionButton: UIButton!
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordAgain: UITextField!
    @IBOutlet weak var telephone: UITextField!
    
    var locationSelectionView = LocationSelectionView()
    var backgroundView = UIView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
    var isTextFieldsSetDefault: Bool!
    
    //let pickerView = UIPickerView()
    let locationArray = ["LEVENT 1C PLAZA", "LEVENT 41D PLAZA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.proceedButton.layer.cornerRadius = 17.5
        
        self.isTextFieldsSetDefault = false
        
        self.nameSurname.setDefaults(placeholderText: "Ad soyad", borderLineWidth: 270)
        self.email.setDefaults(placeholderText: "E-posta adresi", borderLineWidth: 270)
        self.password.setDefaults(placeholderText: "Şifre", borderLineWidth: 270)
        self.passwordAgain.setDefaults(placeholderText: "Şifre tekrar", borderLineWidth: 270)
        self.telephone.setDefaults(placeholderText: "Telefon numarası", borderLineWidth: 270)
        
//        self.pickerView.backgroundColor = UIColor.white
//        self.pickerView.delegate = self
//        self.pickerView.dataSource = self
//        self.pickerView.translatesAutoresizingMaskIntoConstraints = false

//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerDoneButtonTapped))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerCancelButtonTapped))
//        
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
        
//        self.locationSelection.tintColor = UIColor.clear
//        self.locationSelection.layer.masksToBounds = true
//        self.locationSelection.inputAccessoryView = toolBar
//        self.locationSelection.inputView = pickerView

        self.locationSelectionButton.layer.cornerRadius = 17.5
        self.locationSelectionButton.layer.borderWidth = 0.5
        self.locationSelectionButton.layer.borderColor = UIColor(red: 53/255, green: 53/255, blue: 62/255, alpha: 1.0).cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:667)
        self.view.layoutIfNeeded()
        
        self.locationSelectionView.frame = CGRect(x:0, y:163, width:UIScreen.main.bounds.size.width, height: 405)
        self.locationSelectionView.backgroundColor = UIColor.red
        self.locationSelectionView.layer.cornerRadius = 5
        self.locationSelectionView.layer.borderWidth = 1
        self.locationSelectionView.layer.borderColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0).cgColor
        self.locationSelectionView.delegate = self
        
        if !self.isTextFieldsSetDefault {
            self.isTextFieldsSetDefault = !self.isTextFieldsSetDefault
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        print("proceedButtonTapped")
        AppManager.shared().currentUser = User(nameSurname: self.nameSurname.text!, username: self.email.text!, email: self.email.text!, password: self.password.text!)
        print("currentUser: \(AppManager.shared().currentUser)")
        self.textfield.resignFirstResponder()
        self.navigationController?.pushViewController(NewMemberTwoViewController(), animated: true)
    }

    func parseNameSurname() -> (String, String) {
        let nameSurname = self.nameSurname.text!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let wordsAndEmptyStrings:[String] = nameSurname.components(separatedBy: NSCharacterSet.whitespaces)
        let filteredArray = wordsAndEmptyStrings.filter({ $0.count > 0 })
        print("wordsAndEmptyStrings: \(wordsAndEmptyStrings)")
        print("filteredArray: \(filteredArray)")
        
        var name = ""
        var surname = ""
        
        var i = 1;
        
        for str in filteredArray {
            if i != filteredArray.count {
                name = name + str
                name = name + " "
            }
            else {
                surname = str
            }
            i = i + 1
        }
        
        if name.count > 0 {
            let index = name.index(name.endIndex, offsetBy: -1)
            name = String(name[..<index])
        }
        
        print("name: \(name) surname: \(surname)")
        
        return (name, surname)
    }
    
    @IBAction func locationSelectionButtonTapped(_ sender: UIButton) {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.locationSelectionView)
    }
    
    func someFunc(_ index: Int) {
        print("location: \(self.locationArray[index])")
        self.locationSelectionView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
        self.locationSelectionButton.setTitle(self.locationArray[index], for: UIControlState.normal)
        self.locationSelectionButton.setTitle(self.locationArray[index], for: UIControlState.selected)
        //self.locationSelectionButton.titleLabel?.text = self.locationArray[index]
    }
    
//    @objc func pickerDoneButtonTapped(sender: UIBarButtonItem) {
//        print("pickerDoneButtonTapped with selectedValue: \(self.pickerArray[self.pickerView.selectedRow(inComponent: 0)])")
//        self.locationSelection.text = self.pickerArray[self.pickerView.selectedRow(inComponent: 0)]
//        self.locationSelection.resignFirstResponder()
//    }
//
//    @objc func pickerCancelButtonTapped(sender: UIBarButtonItem) {
//        print("pickerCancelButtonTapped")
//        self.locationSelection.resignFirstResponder()
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return self.pickerArray.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        print("row: \(row)")
//        return self.pickerArray[row]
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
