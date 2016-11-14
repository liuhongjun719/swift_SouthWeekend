//
//  UtilString.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/24.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import YLMoment

extension String {
    
    //获取字符串高度
    func getStringSize(fontSize:CGFloat,width:CGFloat) -> CGSize {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: width, height: 900)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: fontSize), forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize
    }
    
    
    //设置cell上的发表文章的时间
    func getMomentFromNow() -> String {
        let moment = YLMoment.init(dateAs: self, format: "yyyy-MM-dd HH:mm:ss", localeIdentifier: "zh_CN")
        return (moment?.fromNow())!
    }
    
}
