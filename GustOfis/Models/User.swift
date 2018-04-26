//
//  User.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 25/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
    
    var username: String?
    var email: String?
    var password: String?
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        email <- map["email"]
    }
    
}
