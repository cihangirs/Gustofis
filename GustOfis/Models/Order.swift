//
//  Order.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 02/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Order: NSObject, Mappable {
    
    var orderId: Int?
    var parentId: Int?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        orderId <- map["id"]
        parentId <- map["parent_id"]
    }
    
}
