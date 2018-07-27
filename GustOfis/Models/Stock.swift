//
//  Stock.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 24.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Stock: NSObject, Mappable {
    
    var categories: [Categorie]?
    var promotions: [Promotion]?
    var products: [Product]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categories <- map["categories"]
        promotions <- map["promotions"]
        products <- map["products"]
    }
    
}
