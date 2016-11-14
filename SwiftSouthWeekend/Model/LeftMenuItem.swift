//
//  LeftMenuItem.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/26.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import ObjectMapper


class LeftMenuItem: Mappable{
    var sectionName: String?
    var isOpened: Bool?
    var image: String?
    var pressSectionColor: String?
    var id: Int?
    var items: [LeftMenuSubItem]?
    var cat_id: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        sectionName <- map["sectionName"]
        isOpened <- map["isOpened"]
        image <- map["image"]
        pressSectionColor <- map["pressSectionColor"]
        id <- map["id"]
        items <- map["items"]
        cat_id <- map["cat_id"]

        
    }
    
    
}
