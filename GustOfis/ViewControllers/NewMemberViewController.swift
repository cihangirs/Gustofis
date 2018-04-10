//
//  NewMemberViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class NewMemberViewController: ViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var locationSelection: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    
    let pickerView = UIPickerView()
    let pickerArray = ["LEVENT 1C PLAZA", "LEVENT 41D PLAZA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.proceedButton.layer.cornerRadius = 17.5
        
        self.pickerView.backgroundColor = UIColor.white
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickerCancelButtonTapped))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.locationSelection.tintColor = UIColor.clear
        self.locationSelection.layer.cornerRadius = 17.5
        self.locationSelection.layer.masksToBounds = true
        self.locationSelection.inputAccessoryView = toolBar
        self.locationSelection.inputView = pickerView
        self.locationSelection.layer.borderWidth = 0.5
        self.locationSelection.layer.borderColor = UIColor(red: 53/255, green: 53/255, blue: 62/255, alpha: 1.0).cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:667)
        
//        print("before: \(self.gustofisLogoTopConstraint.constant)")
//        
//        self.gustofisLogoTopConstraint.constant = -((self.nameSurname.frame.origin.y - self.gustofisLogo.frame.size.height) / 2)
//        
//        print("after: \(self.gustofisLogoTopConstraint.constant)")
        
        self.view.layoutIfNeeded()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
        self.textfield.becomeFirstResponder()
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
        self.navigationController?.pushViewController(NewMemberTwoViewController(), animated: true)
    }
    
    @objc func pickerDoneButtonTapped(sender: UIBarButtonItem) {
        print("pickerDoneButtonTapped with selectedValue: \(self.pickerArray[self.pickerView.selectedRow(inComponent: 0)])")
        self.locationSelection.text = self.pickerArray[self.pickerView.selectedRow(inComponent: 0)]
        self.locationSelection.resignFirstResponder()
    }
    
    @objc func pickerCancelButtonTapped(sender: UIBarButtonItem) {
        print("pickerCancelButtonTapped")
        self.locationSelection.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("row: \(row)")
        return self.pickerArray[row]
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
