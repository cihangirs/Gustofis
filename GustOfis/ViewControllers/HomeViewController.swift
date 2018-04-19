//
//  HomeViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import PagingMenuController
import JGProgressHUD

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    private let categoriesViewController = CategoriesViewController()
    private let exclusivesViewController = ExclusivesViewController()
    private let filtersViewController = FiltersViewController()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [ViewController] {
        return [categoriesViewController, exclusivesViewController, filtersViewController]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
            tabView.tabIcon.image = UIImage(named:"categorieIcon")
            tabView.tabTitle.text = "ÜRÜNLER"
            return .custom(view: tabView)
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
            tabView.tabIcon.image = UIImage(named:"exclusiveIcon")
            tabView.tabTitle.text = "SİZE ÖZEL"
            return .custom(view: tabView)
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3, height: 45))
            tabView.tabIcon.image = UIImage(named:"filterIcon")
            tabView.tabTitle.text = "FİLTRELE"
            return .custom(view: tabView)
        }
    }
}

class HomeViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        pagingMenuController.view.frame = view.frame
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)

        pagingMenuController.move(toPage: 1, animated: false)
        // Do any additional setup after loading the view.
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)

        NetworkManager.shared().fetchProducts(completionHandler: { productArray in
        
            (options.pagingControllers[1] as! ExclusivesViewController).productArray = productArray;
            (options.pagingControllers[1] as! ExclusivesViewController).exclusiveTableView.reloadData()
//            for product in self.productArray
//            {
//                //self.myTextView.text.append("productId: \(product.productId!) productName: \(product.name!)\n")
//                print("productId: \(product.productId!) productName: \(product.name!)\n")
//            }
            
            hud.dismiss()
        })
        
        NetworkManager.shared().fetchCategories(completionHandler: { categorieArray in
            
            //self.categorieArray = categorieArray;
            
            (options.pagingControllers[0] as! CategoriesViewController).categorieArray = categorieArray
            (options.pagingControllers[0] as! CategoriesViewController).categoryTableView.reloadData()
//            for categorie in self.categorieArray
//            {
//                print("categorieId: \(categorie.categorieId!) parentId: \(categorie.name!)\n")
//            }
            
            hud.dismiss()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
