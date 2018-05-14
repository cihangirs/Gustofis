//
//  AppManager.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 02/05/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import UIKit

class AppManager: NSObject {

    var currentUser: User!
    var userToken: String!
    var avatarUrl: String!
    
    private static var sharedAppManager: AppManager = {
        
        let appManager = AppManager()
        
        return appManager
    }()
    
    class func shared() -> AppManager {
        return sharedAppManager
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
