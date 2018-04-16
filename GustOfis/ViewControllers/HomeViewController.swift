//
//  HomeViewController.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import PagingMenuController

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    private let viewController1 = CategoriesViewController()
    private let viewController2 = ExclusivesViewController()
    private let viewController3 = FiltersViewController()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [ViewController] {
        return [viewController1, viewController2, viewController3]
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
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: 125, height: 45))
            tabView.tabIcon = UIImageView(image: UIImage(named:"categorieIcon.png"))
            tabView.tabTitle.text = "ÜRÜNLER"
            return .custom(view: tabView)
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: 125, height: 45))
            tabView.tabIcon = UIImageView(image: UIImage(named:"exclusiveIcon.png"))
            tabView.tabTitle.text = "SİZE ÖZEL"
            return .custom(view: tabView)
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let tabView = TabView(frame: CGRect(x: 0, y: 0, width: 125, height: 45))
            tabView.tabIcon = UIImageView(image: UIImage(named:"filterIcon.png"))
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
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
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
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)

        pagingMenuController.move(toPage: 1, animated: false)
        pagingMenuController.menuView?.currentMenuItemView.menuImageView.image = UIImage(named: "1.jpg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
