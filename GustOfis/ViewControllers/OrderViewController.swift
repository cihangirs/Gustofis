//
//  OrderViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 25.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD

class OrderViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var orderDateTF: UITextField!
    //@IBOutlet weak var creditCardTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addCreditCardButton: UIButton!

    let pickerView = UIPickerView()
    var toolBar = UIToolbar()
    
    var selectedTextField: UITextField?
    //var myPickerData = [String](arrayLiteral: "Peter", "Jane", "Paul", "Mary", "Kevin", "Lucy")
    var locationData = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPickerElementSelected))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self

//        self.orderDateTF.delegate = self
//        self.orderDateTF.inputView = self.pickerView
//        self.orderDateTF.inputAccessoryView = self.toolBar
//        self.orderDateTF.tintColor = UIColor.clear

//        self.creditCardTF.delegate = self
//        self.creditCardTF.inputView = self.pickerView
//        self.creditCardTF.inputAccessoryView = self.toolBar
//        self.creditCardTF.tintColor = UIColor.clear

        self.addressTF.delegate = self
        self.addressTF.inputView = self.pickerView
        self.addressTF.inputAccessoryView = self.toolBar
        self.addressTF.tintColor = UIColor.clear
        
        self.addCreditCardButton.layer.borderWidth = 1
        self.addCreditCardButton.layer.borderColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
        
        self.checkoutZones()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.title = "SEPETİM"
        
        self.leftBackButton()
    }

    override func leftItemClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Picker functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTextField!.text = locationData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.selectedTextField = textField
        
        //myPickerData = [] //clear out the clicked field data array
        
//        if textField == self.orderDateTF {
//            myPickerData = [String](arrayLiteral: "" ,"Bugün", "Yarın", "Dün", "Seneye", "Haftaya", "Önümüzdeki Ay")
//        }
//        else if textField == self.addressTF {
//            locationData = self.locationData
//        }
//        else {
//            myPickerData = [String](arrayLiteral: "", "1", "2", "3", "4", "5", "6")
//        }
        
        self.pickerView.reloadAllComponents()
        self.pickerView.isHidden = false
        
        return true
    }
    
    func checkoutZones() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().checkoutZones { locationArray in
            self.locationData = locationArray
            print("locationArray: \(locationArray)")
            hud.dismiss()
        }
    }
    
    @objc func didPickerElementSelected() {
        self.selectedTextField!.resignFirstResponder()
        print("didPickerElementSelected")
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
