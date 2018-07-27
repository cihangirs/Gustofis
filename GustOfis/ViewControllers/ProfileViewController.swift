//
//  ProfileViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProfileViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var scrollContentView: UIView!
    
    var profileMenuArray: [String] = ["Pano", "My Orders", "My Downloads", "Edit Address", "Edit Account", "My Wishlist"]
    var profileMenuIconArray: [String] = ["panoIcon.png", "myOrdersIcon.png", "myDownloadsIcon.png", "editAddressIcon.png", "editAccountIcon.png", "myWishlistIcon.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.saveChangesButton.layer.cornerRadius = 17.5
        self.saveChangesButton.layer.borderWidth = 0.5
        self.saveChangesButton.layer.borderColor = UIColor(red: 114/255, green: 113/255, blue: 143/255, alpha: 1.0).cgColor
        
        self.avatarButton.layer.cornerRadius = 50
        self.avatarButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:903)
//        self.view.setNeedsUpdateConstraints()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLogoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "ProximaNova-Semibold", size: 14)!]
        //self.title = "PROFİLİM"
        
        self.leftBackButton()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ProfileTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProfileTableViewCell.")
        }
        
        cell.profileMenuLabel.text = self.profileMenuArray[indexPath.row]
        cell.profileMenuIW.image = UIImage(named: self.profileMenuIconArray[indexPath.row])
        //cell.categorie = self.categorieArray[indexPath.row]
        //cell.categorieLabel.text = "sdfgsdgs" //self.categorieArray[indexPath.row].name
        
        //        cell.separatorInset = UIEdgeInsets.zero;
        //        cell.contentView.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        //        cell.backgroundColor = UIColor(red: 49/255, green: 49/255, blue: 57/255, alpha: 1.0)
        // set the text from the data model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    @IBAction func avatarButtonTapped(_ sender: UIButton) {

        let alert = UIAlertController(title: "Photo Upload", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            print("User click Camera button")
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default , handler:{ (UIAlertAction)in
            print("User click Photo Library button")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatarButton.setImage(image, for: UIControlState.normal)
        dismiss(animated:true, completion: nil)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        NetworkManager.shared().updateAvatar(image: image, completionHandler: { avatarUrl in
            AppManager.shared().avatarUrl = avatarUrl
            hud.dismiss()
        })
    }
    
    override func leftItemClicked() {
        self.navigationController?.popViewController(animated: true)
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
