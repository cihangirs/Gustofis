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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //sleep(1)
        
        firstViewController.tabBarItem = UITabBarItem(title: "First", image: UIImage(named: "first"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "second"), tag: 0)
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "third"), tag: 0)
        fourthViewController.tabBarItem = UITabBarItem(title: "Fourth", image: UIImage(named: "fourth"), tag: 0)
        
        let tabBarController = UITabBarController()
        let controllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        tabBarController.viewControllers = controllers
        
        let navigationController = UINavigationController(rootViewController: loginScreenViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        //window?.rootViewController = tabBarController
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible()
        
        return true
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

