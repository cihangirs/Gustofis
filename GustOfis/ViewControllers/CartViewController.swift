//
//  CartViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD
import UIAlertController_Blocks

class CartViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cartScrollView: UIScrollView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cartTotal: UILabel!
    @IBOutlet weak var shippingTotal: UILabel!
    @IBOutlet weak var orderTotal: UILabel!
    
    @IBOutlet weak var orderDateTF: UITextField!
    @IBOutlet weak var creditCardTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var promotionButton: UIButton!
    
    let pickerView = UIPickerView()
    var toolBar = UIToolbar()
    
    var selectedTextField: UITextField?
    var myPickerData = [String](arrayLiteral: "", "1", "2", "3", "4", "5", "6", "7", "8", "9")
    
    var cart = Cart()
    
    var selectedDateIndex: Int = 0
    var selectedCreditCardIndex: Int = 0
    var selectedAddressIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchCartItems()
        
        self.toolBar.barStyle = UIBarStyle.default
        self.toolBar.isTranslucent = false
        self.toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        self.toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(didPickerElementSelected))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        self.toolBar.setItems([spaceButton, doneButton], animated: false)
        self.toolBar.isUserInteractionEnabled = true
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
//        self.orderDateTF.delegate = self
//        self.orderDateTF.inputView = self.pickerView
//        self.orderDateTF.inputAccessoryView = self.toolBar
//        self.orderDateTF.tintColor = UIColor.clear
//
//        self.creditCardTF.delegate = self
//        self.creditCardTF.inputView = self.pickerView
//        self.creditCardTF.inputAccessoryView = self.toolBar
//        self.creditCardTF.tintColor = UIColor.clear
//
//        self.addressTF.delegate = self
//        self.addressTF.inputView = self.pickerView
//        self.addressTF.inputAccessoryView = self.toolBar
//        self.addressTF.tintColor = UIColor.clear
        
        self.cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.promotionButton.layer.borderWidth = 1
        self.promotionButton.layer.borderColor = UIColor(red: 65/255, green: 64/255, blue: 94/255, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "deleteBasketIcon.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(rightItemClicked))
        
        self.title = "SEPETİM"
        
        self.leftBackButton()
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return false
//    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//
//        self.selectedTextField = textField
//
//        myPickerData = [] //clear out the clicked field data array
//
//        if textField == self.orderDateTF {
//            myPickerData = [String](arrayLiteral: "" ,"Bugün", "Yarın", "Dün", "Seneye", "Haftaya", "Önümüzdeki Ay")
//        }
//        else if textField == self.creditCardTF {
//            myPickerData = [String](arrayLiteral: "", "1111000022223333", "1111000022224444", "1111000022225555", "1111000022226666", "1111000022227777", "1111000022228888")
//        }
//        else if textField == self.addressTF {
//            myPickerData = [String](arrayLiteral: "", "Kadıköy", "Beşiktaş", "Karaköy", "Levent", "Şişli", "Sarıyer")
//        }
//        else {
//            myPickerData = [String](arrayLiteral: "", "1", "2", "3", "4", "5", "6", "7", "8", "9")
//        }
//
//        self.pickerView.reloadAllComponents()
//
//        return true
//    }
    

// MARK: - tableView delegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: CartTableViewCell = tableView.cellForRow(at: indexPath) as! CartTableViewCell
        self.selectedTextField = selectedCell.cartItemCountTF
        self.selectedTextField?.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CartTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CartTableViewCell.")
        }
        
        cell.delegate = self
        //cell.cartItemCountTF.delegate = self
        cell.cartItemCountTF.inputView = self.pickerView
        cell.cartItemCountTF.inputAccessoryView = self.toolBar
        cell.cartItemCountTF.tag = indexPath.section
        
        let cartItem = self.cart.items[indexPath.section]
        
        cell.cartItemCountTF.text = "\(cartItem.quantity!)"
        cell.cartItemName.text = cartItem.productTitle
        //cell.cartItemIngredients.text = cartItem.
        cell.cartItemPrice.text = "\(cartItem.total!) TL"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cart.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let more = UITableViewRowAction(style: .normal, title: "Delete") { action, index in

            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            
            NetworkManager.shared().removeFromCart(productId: Int(self.cart.items[indexPath.section].productId!), completionHandler: { cart in
                self.cart = cart
                self.cartTableView.reloadData()
                self.cartTableView.layoutIfNeeded()
                self.cartTableView.clipsToBounds = true
                self.cartTableViewHeightConstraint.constant = self.cartTableView.contentSize.height
                hud.dismiss()
            })
        }
        more.backgroundColor = UIColor.red

        return [more]
    }
    
// MARK: - pickerView delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTextField?.text = myPickerData[row]
    }

// MARK: - action methods
    
    @objc func didPickerElementSelected(sender: Any) {
        self.selectedTextField?.resignFirstResponder()
        self.updateCart(self.cart.items[self.selectedTextField!.tag].productId!, Int(self.selectedTextField!.text!)!)
    }
    
    @IBAction func didProceedButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(OrderViewController(), animated: true)
    }

    override func leftItemClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func rightItemClicked() {
        
        UIAlertController.showAlert(
            in: self,
            withTitle: "",
            message: "Sepeti boşaltmak istediğinizden emin misiniz?",
            cancelButtonTitle: "Hayır",
            destructiveButtonTitle: nil,
            otherButtonTitles: ["Evet"],
            tap: {(controller, action, buttonIndex) in
                if buttonIndex == controller.cancelButtonIndex {
                    print("Cancel Tapped")
                }
                else
                {
                    self.deleteAllCartItems()
                }
        }
        )
    }
    
// MARK: - network calls
    
    func updateCart(_ productId: Int, _ quantity: Int){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().updateCart(productId: productId, quantity: quantity) { cart in
            print("cart: \(cart)")
            self.cart = cart
            self.cartTableView.reloadData()
            self.cartTableView.layoutIfNeeded()
            self.cartTableView.clipsToBounds = true
            self.cartTableViewHeightConstraint.constant = self.cartTableView.contentSize.height
  
            let cartTotal = self.cart.cartTotal
            let shippingTotal = self.cart.shippingTotal
            let orderTotal = cartTotal! + shippingTotal!
            
            self.cartTotal.text = "\(self.cart.cartTotal!) TL"
            self.shippingTotal.text = "\(self.cart.shippingTotal!) TL"
            self.orderTotal.text = "\(orderTotal) TL"
            
            hud.dismiss()
        }
    }
    
    func fetchCartItems() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.backgroundColor = UIColor.white
        
        NetworkManager.shared().fetchCart(completionHandler: { cart in
            self.cart = cart
            self.cartTableView.reloadData()
            self.cartTableView.layoutIfNeeded()
            self.cartTableView.clipsToBounds = true
            self.cartTableViewHeightConstraint.constant = self.cartTableView.contentSize.height
            
            let cartTotal = self.cart.cartTotal
            let shippingTotal = self.cart.shippingTotal
            let orderTotal = cartTotal! + shippingTotal!
            
            self.cartTotal.text = "\(self.cart.cartTotal!) TL"
            self.shippingTotal.text = "\(self.cart.shippingTotal!) TL"
            self.orderTotal.text = "\(orderTotal) TL"
            
            hud.dismiss()
        })
    }
    
    func deleteAllCartItems() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().removeAllFromCart { removeAllFromCartResponse in
            print("removeAllFromCartResponse: \(removeAllFromCartResponse)")
            hud.dismiss()
            
            self.navigationController?.popViewController(animated: true)
        }
    }

}
