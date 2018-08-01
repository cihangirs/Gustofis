//
//  AppDelegate.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 28/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let firstViewController: FirstViewController = FirstViewController()
    let secondViewController: SecondViewController = SecondViewController()
    let thirdViewController: ThirdViewController = ThirdViewController()
    let fourthViewController: FourthViewController = FourthViewController()

    let loginScreenViewController: LoginScreenViewController = LoginScreenViewController()
    let exclusivesViewController: ProductsViewController = ProductsViewController()
    let filtersViewController: FiltersViewController = FiltersViewController()
    let profileViewController: ProfileViewController = ProfileViewController()
    
    let tempViewController1: TempViewController = TempViewController()
    let tempViewController2: TempViewController = TempViewController()
    let tempViewController3: TempViewController = TempViewController()
    let tempViewController4: TempViewController = TempViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        loginScreenViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: loginScreenViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible()
        
        return true
    }

    func userDidLogin()
    {
        exclusivesViewController.appDelegate = self
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        let tabBarController = UITabBarController()
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarHomeIcon"), tag: 0)
        tempViewController1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarSearchIcon"), tag: 1)
        tempViewController2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarKioskIcon"), tag: 2)
        tempViewController3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarChatIcon"), tag: 3)
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarSettingsIcon"), tag: 4)
        let controllers = [navigationController, tempViewController1, tempViewController2, tempViewController3, profileViewController]
        tabBarController.viewControllers = controllers
        
        window?.rootViewController = tabBarController
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

