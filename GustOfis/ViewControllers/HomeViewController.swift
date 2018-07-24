//
//  HomeViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
//import PagingMenuController
import JGProgressHUD

//private struct PagingMenuOptions: PagingMenuControllerCustomizable {
//    let categoriesViewController = CategoriesViewController()
//    let exclusivesViewController = ExclusivesViewController()
//    let filtersViewController = FiltersViewController()
//
//    fileprivate var componentType: ComponentType {
//        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
//    }
//
//    fileprivate var pagingControllers: [ViewController] {
//        return [categoriesViewController, exclusivesViewController, filtersViewController]
//    }
//
//    fileprivate struct MenuOptions: MenuViewCustomizable {
//        var displayMode: MenuDisplayMode {
//            return .segmentedControl
//        }
//        var itemsOptions: [MenuItemViewCustomizable] {
//            return [MenuItem1(), MenuItem2(), MenuItem3()]
//        }
//    }
//
//    fileprivate struct MenuItem1: MenuItemViewCustomizable {
//        var displayMode: MenuItemDisplayMode {
//            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
//            tabView.tabIcon.image = UIImage(named:"categorieIcon")
//            tabView.tabTitle.text = "ÜRÜNLER"
//            return .custom(view: tabView)
//        }
//    }
//    fileprivate struct MenuItem2: MenuItemViewCustomizable {
//        var displayMode: MenuItemDisplayMode {
//            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
//            tabView.tabIcon.image = UIImage(named:"exclusiveIcon")
//            tabView.tabTitle.text = "SİZE ÖZEL"
//            return .custom(view: tabView)
//        }
//    }
//    fileprivate struct MenuItem3: MenuItemViewCustomizable {
//        var displayMode: MenuItemDisplayMode {
//            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
//            tabView.tabIcon.image = UIImage(named:"filterIcon")
//            tabView.tabTitle.text = "FİLTRELE"
//            return .custom(view: tabView)
//        }
//    }
//}

class HomeViewController: ViewController {

    @IBOutlet weak var headerLogo: UIImageView!
    
//    fileprivate let options = PagingMenuOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let pagingMenuController = PagingMenuController(options: options)
//        pagingMenuController.onMove = { state in
//            switch state {
//                case let .willMoveController(menuController, previousMenuController):
//                    print(previousMenuController)
//                    print(menuController)
//                case let .didMoveController(menuController, previousMenuController):
//                    print(previousMenuController)
//                    print(menuController)
//                case let .willMoveItem(menuItemView, previousMenuItemView):
//                    print(previousMenuItemView)
//                    print(menuItemView)
//                case let .didMoveItem(menuItemView, previousMenuItemView):
//                    print(previousMenuItemView)
//                    print(menuItemView)
//                case .didScrollStart:
//                    print("Scroll start")
//                case .didScrollEnd:
//                    print("Scroll end")
//                }
//        }
//
//        pagingMenuController.view.frame = view.frame
//        pagingMenuController.view.frame.origin.y += 44
//        pagingMenuController.view.frame.size.height -= 44
//
//        addChildViewController(pagingMenuController)
//        view.addSubview(pagingMenuController.view)
//        pagingMenuController.didMove(toParentViewController: self)
//
//        pagingMenuController.move(toPage: 1, animated: false)
//        // Do any additional setup after loading the view.
//
//        self.setChildViewControllersDelegate(pagingViewControllers: pagingMenuController.pagingViewController!)

        //self.fetchProducts()
//        self.fetchCategories()
//        self.fetchFilters()
        //print("pagingMenuController.pagingViewController: \(pagingMenuController.pagingViewController!)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true

        
        self.title = "some title"
        //self.view.bringSubview(toFront: self.headerLogo)
        //self.headerLogo.didMoveToWindow()
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
//        self.leftBackButton()
//        self.rightShareButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func fetchProducts() {
//    
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//
//        NetworkManager.shared().fetchProducts(completionHandler: { productArray in
//            self.options.exclusivesViewController.productArray = productArray;
//            self.options.exclusivesViewController.exclusiveTableView.reloadData()
//            //            for product in self.productArray
//            //            {
//            //                //self.myTextView.text.append("productId: \(product.productId!) productName: \(product.name!)\n")
//            //                print("productId: \(product.productId!) productName: \(product.name!)\n")
//            //            }
//            
//            hud.dismiss()
//        })
//    }
//    
//    func fetchCategories() {
//        
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        
//        NetworkManager.shared().fetchCategories(completionHandler: { categorieArray in
//            
//            //self.categorieArray = categorieArray;
//            
//            self.options.categoriesViewController.categorieArray = categorieArray
//            self.options.categoriesViewController.categoryTableView.reloadData()
//            //            for categorie in self.categorieArray
//            //            {
//            //                print("categorieId: \(categorie.categorieId!) parentId: \(categorie.name!)\n")
//            //            }
//            
//            hud.dismiss()
//        })
//    }
//    
//    func fetchCategorieProducts(categorieId: Int) {
//        
//        print("self.childViewControllers: \(self.childViewControllers)")
//        
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        
//        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
//        pagingMenuController.move(toPage: 1)
//        
//        NetworkManager.shared().fetchCategorieProducts(categorieId:categorieId, completionHandler: { productArray in
//            
//            //self.categorieArray = categorieArray;
//            
//            self.options.exclusivesViewController.productArray = productArray
//            self.options.exclusivesViewController.exclusiveTableView.reloadData()
//            //            for categorie in self.categorieArray
//            //            {
//            //                print("categorieId: \(categorie.categorieId!) parentId: \(categorie.name!)\n")
//            //            }
//            
//            hud.dismiss()
//        })
//    }
//    
//    func fetchFilters() {
//        
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        
//        NetworkManager.shared().fetchFilters(completionHandler: { filterArray in
//            
//            //self.categorieArray = categorieArray;
//            print("filterArray: \(filterArray)")
//            
//            self.options.filtersViewController.filterArray = filterArray
//            self.options.filtersViewController.filterTableView.reloadData()
//            //            for categorie in self.categorieArray
//            //            {
//            //                print("categorieId: \(categorie.categorieId!) parentId: \(categorie.name!)\n")
//            //            }
//            
//            hud.dismiss()
//        })
//    }
//    
//    func setChildViewControllersDelegate(pagingViewControllers: PagingViewController) {
////        for pagingViewController in pagingViewControllers.controllers {
////            pagingViewController.
////        }
//        (pagingViewControllers.controllers[0] as! CategoriesViewController).delegate = self
//        (pagingViewControllers.controllers[1] as! ExclusivesViewController).delegate = self
//        (pagingViewControllers.controllers[2] as! FiltersViewController).delegate = self
//    }

}
