//
//  Filter.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 24/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Filter: NSObject, Mappable {
    
    var filterId: Int?
    var filterName: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        filterId <- map["id"]
        filterName <- map["name"]
    }
    
}
