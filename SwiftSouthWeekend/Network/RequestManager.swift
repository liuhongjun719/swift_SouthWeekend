//
//  RequestManager.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/4.
//  Copyright © 2016年 123456. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

open class RequestManager {
    
    typealias RequestSucceedHandler = (_ responseSucceedObject: [ModelItem]) -> Void
    typealias RequestErrorHandler = (_ responseError: Error) -> Void

    

    class var sharedInstance :RequestManager {
        struct Singleton {
            static let instance = RequestManager()
        }
        return Singleton.instance
    }
    
    
    func requestWithUrl(url: String, requestSucceedHandler: @escaping RequestSucceedHandler, requestErrorHandler: @escaping RequestErrorHandler) {
        Alamofire.request(url).validate().responseArray { (response: DataResponse<[ModelItem]>) in
            switch response.result {
            case .success(let value):
                requestSucceedHandler(value)
                print("succeed-------------")
            case .failure(let error):
                requestErrorHandler(error)
                print("error-------------:\(error)")
            }
        }
    }
}







