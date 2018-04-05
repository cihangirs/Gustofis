//
//  NewMemberViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class NewMemberViewController: ViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var locationSelection: UITextField!
    
    let pickerView = UIPickerView()
    let pickerArray = ["First", "Second"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.locationSelection.inputAccessoryView = toolBar
        self.locationSelection.inputView = pickerView
        // Do any additional setup after loading the view.
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
