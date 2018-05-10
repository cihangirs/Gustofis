//
//  Product.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 03/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: NSObject, Mappable {
    
    var productId: Int?
    var name: String?
    var link: String?
    var featured: Bool?
    var productDescription: String?
    var shortDescription: String?
    var price: String?
    var inStock: Bool?
    var images: [ProductImage]?
    var relatedIds: [Int]?
    var nutritionalValues: [Nutrition]?
    var aboutManufacturer: String?
    var additionalInformations: String?
    var preservation: String?
    var shelfLife: String?
    var ingredients: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        productId <- map["id"]
        name <- map["name"]
        link <- map["link"]
        featured <- map["featured"]
        productDescription <- map["description"]
        shortDescription <- map["short_description"]
        price <- map["price"]
        inStock <- map["in_stock"]
        images <- map["images"]
        relatedIds <- map["related_ids"]
        nutritionalValues <- map["besin_degerleri"]
        aboutManufacturer <- map["uretici_hakkinda"]
        additionalInformations <- map["ek_bilgiler"]
        preservation <- map["saklama"]
        shelfLife <- map["raf_omru"]
        ingredients <- map["icindekiler"]
    }
    
}
