//
//  Nutrition.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 10.05.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Nutrition: NSObject, Mappable {
    
    var name: String?
    var value: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
    }
    
}
