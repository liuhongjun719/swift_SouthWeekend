//
//  LeftMenuSubItem.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import ObjectMapper

class LeftMenuSubItem: Mappable {
    var title: String?
    var pressCellColor: String?
    var cat_id: String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        pressCellColor <- map["pressCellColor"]
        cat_id <- map["cat_id"]
    }
}
