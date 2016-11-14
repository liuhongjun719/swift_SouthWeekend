//
//  InvestigateViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/21.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit

class InvestigateViewController: UIViewController {
    
    
    //点击cell执行block
    typealias DidSelectItemAtBlock = (_ modelItem: ModelItem) -> Swift.Void
    var didSelectItemAtBlock:DidSelectItemAtBlock!
    
    
    var homeCollectionView: HomeCollectionView!
    var start: Int = 0
    var count: Int = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start = 0
        self.count = 11
        homeCollectionView = HomeCollectionView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-40-64))
        self.view.addSubview(homeCollectionView)
        
        
        //点击cell
        homeCollectionView.didSelectItemAtBlock = {(modelItem) in
            self.didSelectItemAtBlock(modelItem)
        }
        
        
        //下拉刷新
        homeCollectionView.headerRefreshBlock = {() in
            self.start = 0
            self.getData()
        }
        
        //上拉加载
        homeCollectionView.footerLoadMoreBlock = {() in
            self.start += 1
            self.getData()
        }
        
        
        
        //Array
        self.getData()
        
    }
    
    
    func getData() {
        let url = "http://www.infzm.com/mobile/get_list_by_cat_ids?cat_id%5B%5D=4714&" + String.init(format: "start=%i&count=%i", self.start, self.count) + "&platform=ireader&device=Unknown%20iPhone&version=5.1.0&system_version=9.3&hash=f2cdde51e779dd63b44690b9c86b216b&format=json"
        print("url---------:\(url)")
        
        RequestManager.sharedInstance.requestWithUrl(url: url, requestSucceedHandler: { (value) in
            self.homeCollectionView.endRefreshing()
            self.homeCollectionView.parseModels(data: value, start: self.start, className: NSStringFromClass(HeadViewController.self).components(separatedBy: ".").last!)
            
        }) { (error) in
            self.homeCollectionView.endRefreshing()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
