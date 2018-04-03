//
//  Categorie.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 03/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Categorie: NSObject, Mappable {
    
    var categorieId: Int?
    var name: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categorieId <- map["id"]
        name <- map["name"]
    }
    
}
