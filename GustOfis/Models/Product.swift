//
//  Product.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 03/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: NSObject, Mappable {
    
    var productId: Int?
    var name: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        productId <- map["id"]
        name <- map["name"]
    }
    
}
