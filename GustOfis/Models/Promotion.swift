//
//  Promotion.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 24.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Promotion: NSObject, Mappable {
    
//    var orderId: Int?
//    var parentId: Int?
//    var billing: Billing?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
//        orderId <- map["id"]
//        parentId <- map["parent_id"]
//        billing <- map["billing"]
    }
    
}
