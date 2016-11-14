//
//  ModelItem.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/21.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelItem: Mappable {

    var short_subject: String?
    var media: String?//图片
    var modified: String?//时间
    var source: String?//防务
    var comment_count: Int?
    var share_count: Int?
    var abstract_medias: [String]?//cell中的3张图片
    var introtext: String?
    var snsShare: Dictionary<String, String>?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        short_subject <- map["short_subject"]
        media <- map["media"]
        modified <- map["modified"]
        source <- map["source"]
        comment_count <- map["comment_count"]
        share_count <- map["share_count"]
        abstract_medias <- map["abstract_medias"]
        introtext <- map["introtext"]
        snsShare <- map["snsShare"]


    }
    
    
    
    
    
    
}
