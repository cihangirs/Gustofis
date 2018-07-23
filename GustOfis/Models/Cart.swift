//
//  Cart.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 18.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Cart: NSObject, Mappable {

    var cartTotal: Double?
    var shippingTotal: Double?
    var items = [CartItem]()
    var locations: [Location]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cartTotal <- map["cart_total"]
        shippingTotal <- map["shipping_total"]
        items <- map["items"]
        locations <- map["locations"]
    }
    
}
