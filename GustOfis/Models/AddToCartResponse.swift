//
//  AddToCartResponse.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 23.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class AddToCartResponse: NSObject, Mappable {
    
    var code: Int?
    var message: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
    
}
