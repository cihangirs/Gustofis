//
//  Billing.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 03/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Billing: NSObject, Mappable {
    
    var firstName: String?
    var lastName: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
    }
    
}
