//
//  MenuData.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/26.
//  Copyright © 2016年 123456. All rights reserved.
//

import Foundation
import ObjectMapper


class MenuData  {
    static let sharedInstance = MenuData()

    lazy var dataArray: NSArray = {
        var dataArray = NSArray()
        let path = Bundle.main.path(forResource:"LeftMenuData", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let jsonDic = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            dataArray = jsonDic["sections"] as! NSArray
               
        }catch let erro as Error!{
            print("读取本地数据出现错误！",erro)
        }
        
        
        return dataArray
    }()
}






//class MenuData  {
//    static let sharedInstance = MenuData()
//    
//    lazy var dataArray: NSMutableArray = {
//        var dataArray = NSMutableArray()
//        let path = Bundle.main.path(forResource:"LeftMenuData", ofType: "json")
//        let url = URL(fileURLWithPath: path!)
//        do{
//            let data = try Data(contentsOf: url)
//            let jsonDic = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//
//            for dic in jsonDic.object(forKey: "sections") as! NSArray{
//                let menuItem = Mapper<LeftMenuItem>().map(JSON: dic as! [String : Any])
//                dataArray.add(menuItem)
//            }
//            
//            
//            
//        }catch let erro as Error!{
//            print("读取本地数据出现错误！",erro)
//        }
//        
//        
//        return dataArray
//    }()
//}
