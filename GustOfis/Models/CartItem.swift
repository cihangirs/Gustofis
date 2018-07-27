//
//  CartItem.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class CartItem: NSObject, Mappable {

    var productId: Int?
    var productTitle: String?
    var quantity: Int?
    var total: Double?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        productId <- map["product_id"]
        productTitle <- map["product_title"]
        quantity <- map["quantity"]
        total <- map["total"]
    }
    
}
