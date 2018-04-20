//
//  ProductImage.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 19/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductImage: NSObject, Mappable {
    
    var src: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        src <- map["src"]
    }
    
}
