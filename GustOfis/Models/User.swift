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
    
    var id: Int?            //keeps user id
    var name: String?       //keeps name and surname with a space between them
    var surname: String?    //no usage right now
    var username: String?   //no usage right now
    var email: String?
    var password: String?
    var location: Int?
    var telephone: String?

    init(email: String, password: String) {
        //let(name, surname) = User.parseNameSurname(nameSurname: nameSurname)
        //self.name = nameSurname
        //        self.surname = surname
        //        self.username = username
        self.email = email
        self.password = password
    }
    
    init(nameSurname: String, email: String, password: String, location: Int, telephone: String) {
        //let(name, surname) = User.parseNameSurname(nameSurname: nameSurname)
        self.name = nameSurname
//        self.surname = surname
//        self.username = username
        self.email = email
        self.password = password
        self.location = location
        self.telephone = telephone
    }
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    class func parseNameSurname(nameSurname: String) -> (String, String) {
        let nameSurname = nameSurname.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let wordsAndEmptyStrings:[String] = nameSurname.components(separatedBy: NSCharacterSet.whitespaces)
        let filteredArray = wordsAndEmptyStrings.filter({ $0.count > 0 })
        //print("wordsAndEmptyStrings: \(wordsAndEmptyStrings)")
        //print("filteredArray: \(filteredArray)")
        
        var name = ""
        var surname = ""
        
        var i = 1;
        
        for str in filteredArray {
            if i != filteredArray.count {
                name = name + str
                name = name + " "
            }
            else {
                surname = str
            }
            i = i + 1
        }
        
        if name.count > 0 {
            let index = name.index(name.endIndex, offsetBy: -1)
            name = String(name[..<index])
        }
        
        print("name: \(name) surname: \(surname)")
        
        return (name, surname)
    }
    
    func mapping(map: Map) {
//        name <- map["first_name"]
//        surname <- map["last_name"]
//        username <- map["username"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }
    
}
