//
//  SearchResultViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/3.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit


class SearchResultViewController: ParentViewController {
    
    //点击cell执行block
//    typealias DidSelectItemAtBlock = (_ modelItem: ModelItem) -> Swift.Void
//    var didSelectItemAtBlock:DidSelectItemAtBlock!
    
    
    var searchCollectionView: SearchCollectionView!
    var start: Int = 0
    var count: Int = 10
    var searchBar: HJSearchBar!
    var searchText: String?
    var modelArray: [ModelItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        searchBar = HJSearchBar(frame: CGRect.init(x: 60, y: 10, width: (self.navigationController?.navigationBar.frame.size.width)!-70, height: 25))
        self.navigationController?.navigationBar.addSubview(searchBar)
        searchBar.textFieldShouldSearchBlock = {(searchText) in
            self.searchText = searchText
            self.getData()
        }
        
        searchBar.textFieldShouldBeginEditingBlock = {() in
            self.searchBar.updateComponentConstrainWhenGetResponder()
        }
        
        leftButton.setBackgroundImage(UIImage(named: "search_back.png"), for: .normal)
         UINavigationBar.appearance().barStyle = .blackTranslucent
        
        
        self.addCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        searchBar.becomeResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 163/255.0, green: 0/255.0, blue: 15/255.0, alpha: 1.0)
        searchBar.removeFromSuperview()
    }
    
    func addCollectionView() {
        searchCollectionView = SearchCollectionView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(searchCollectionView)
        
        //点击blank控制搜索框约束
        searchCollectionView.blankDidClickedBlock = {() in
            self.searchBar.endEditing(true)
            self.searchBar.updateComponentConstrainWhenResignResponder()
        }
        
        //点击cell
        searchCollectionView.didSelectItemAtBlock = {(modelItem) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        
        //下拉刷新
        searchCollectionView.headerRefreshBlock = {() in
            self.start = 0
            self.getData()
        }
        
        //上拉加载
        searchCollectionView.footerLoadMoreBlock = {() in
            self.start += 1
            self.getData()
        }

    }
    
    
    func getData() {
        
        let encodeSearch = (self.searchText)?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        let url = "http://www.infzm.com/mobile/search?" + String.init(format: "start=%i&count=%i", self.start, self.count) + "&keywords%5B%5D=" + String.init(format: "%@", encodeSearch!) + "&platform=ireader&device=Unknown%20iPhone&version=5.1.0&system_version=9.3&hash=8ae3aa704a5447b574dbb99e05ab82af&format=json"
        print("url---------:\(url)")


        RequestManager.sharedInstance.requestWithUrl(url: url, requestSucceedHandler: { (value) in
            self.searchCollectionView.endRefreshing()
            self.searchCollectionView.parseModels(data: value, start: self.start, className: NSStringFromClass(HeadViewController.self).components(separatedBy: ".").last!)
            self.searchCollectionView.removeBlankView()

            }) { (error) in
                self.searchCollectionView.endRefreshing()
        }


        
        
    }

    

}
