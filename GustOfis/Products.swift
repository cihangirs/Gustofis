//
//  Products.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 30/03/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import ObjectMapper

class Products: Mappable {
//    var username: String?
//    var age: Int?
//    var weight: Double!
    var array: [Any]?
//    var dictionary: [String : Any] = [:]
////    var bestFriend: User?                       // Nested User object
////    var friends: [User]?                        // Array of Users
//    var birthday: Date?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
//        username    <- map["username"]
//        age         <- map["age"]
//        weight      <- map["weight"]
        array       <- map["arr"]
//        dictionary  <- map["dict"]
////        bestFriend  <- map["best_friend"]
////        friends     <- map["friends"]
//        birthday    <- (map["birthday"], DateTransform())
    }
}
