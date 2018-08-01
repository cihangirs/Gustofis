//
//  HomeViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import JGProgressHUD

class HomeViewController: ViewController {

    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var headerLogo: UIImageView!
    
    var productsViewController = ProductsViewController()
    var filtersViewController = FiltersViewController()
    
    var isDrawerOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerScrollView.backgroundColor = UIColor(red: 245/255, green: 242/255, blue: 242/255, alpha: 1.0)
        
        self.containerScrollView.isScrollEnabled = false
        
        self.containerScrollView.contentSize = CGSize(width: 2 * self.containerScrollView.frame.size.width - 105, height: self.containerScrollView.frame.size.height)
        self.containerScrollView.addSubview(self.productsViewController.view)
        self.addChildViewController(self.productsViewController)
        
        self.filtersViewController.view.frame = CGRect(origin: CGPoint(x: self.containerScrollView.frame.size.width , y: self.containerScrollView.frame.origin.y), size: CGSize(width: self.containerScrollView.frame.size.width, height: self.containerScrollView.frame.size.height))
        self.containerScrollView.addSubview(self.filtersViewController.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filterMenuIcon.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightItemClicked))
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "headerLogo.png"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightItemClicked() {
        if !self.isDrawerOpen
        {
            self.containerScrollView.scrollRectToVisible(CGRect(origin: CGPoint(x: self.containerScrollView.frame.size.width - 105, y: 0), size: self.containerScrollView.frame.size), animated: true)
        }
        else
        {
            self.containerScrollView.scrollRectToVisible(CGRect(origin: CGPoint.zero, size: self.containerScrollView.frame.size), animated: true)
        }
        self.isDrawerOpen = !self.isDrawerOpen
    }

}
