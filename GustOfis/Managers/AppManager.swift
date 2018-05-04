//
//  AppManager.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 02/05/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation

class AppManager: NSObject {

    var currentUser: User!
    
    private static var sharedAppManager: AppManager = {
        
        let appManager = AppManager()
        
        return appManager
    }()
    
    class func shared() -> AppManager {
        return sharedAppManager
    }
    
}
