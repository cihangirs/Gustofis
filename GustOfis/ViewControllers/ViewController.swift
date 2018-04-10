//
//  ViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import Crashlytics

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton(type: .roundedRect)
//        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//        button.setTitle("Crash", for: [])
//        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
//        view.addSubview(button)

    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo
        let keyboardFrame = userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
        self.scrollView.scrollRectToVisible(self.textfield.frame, animated: true)
    }
    
    @objc func keyboardWillHide(note: NSNotification){
        let contentInset = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
    }
    
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }

    // UITabBarDelegate
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
////        print("navCon: \(self.navigationController!)")
////
////        switch item.tag {
////            case 0:
////                self.navigationController?.pushViewController(firstViewController, animated: true)
////                print("Selected item \(item.tag)")
////            case 1:
////                self.navigationController?.pushViewController(secondViewController, animated: true)
////                print("Selected item \(item.tag)")
////            case 2:
////                self.navigationController?.pushViewController(thirdViewController, animated: true)
////                print("Selected item \(item.tag)")
////            case 3:
////                self.navigationController?.pushViewController(fourthViewController, animated: true)
////                print("Selected item \(item.tag)")
////            default:
////                print("Selected item \(item.tag)")
////        }
//
//    }
}
