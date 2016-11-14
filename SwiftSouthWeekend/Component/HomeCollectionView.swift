//
//  HomeCollectionView.swift
//  LightningShopping
//
//  Created by 123456 on 16/9/28.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import MJRefresh


class HomeCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //refresh
    typealias HeaderRefreshBlock = () -> Swift.Void
    var headerRefreshBlock: HeaderRefreshBlock!
    
    //load more
    typealias FooterLoadMoreBlock = () -> Swift.Void
    var footerLoadMoreBlock: FooterLoadMoreBlock!
    
    var collectionView: UICollectionView! = nil

    

    //创建block变量
    typealias ScrollViewDidScrollOfHomeBlock = (_ isHidden: Bool) -> Swift.Void
    var homeBlock:ScrollViewDidScrollOfHomeBlock!
    
    
    //
    var modelArray = [ModelItem]()
    var className: String = ""
    
    
    //点击cell执行block
    typealias DidSelectItemAtBlock = (_ modelItem: ModelItem) -> Swift.Void
    var didSelectItemAtBlock:DidSelectItemAtBlock!
    

    
    //MARK: - UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical;
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout);
        collectionView.backgroundColor = UIColor.init(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.addSubview(collectionView)

        collectionView.register(NormalCell.self, forCellWithReuseIdentifier: "NormalCell")
        collectionView.register(AbstractMediasCell.self, forCellWithReuseIdentifier: "AbstractMediasCell")
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.register(NoImageCell.self, forCellWithReuseIdentifier: "NoImageCell")
        collectionView.register(HeadCell.self, forCellWithReuseIdentifier: "HeadCell")
        
        self.addRefreshHeader()
        self.addLoadMoreFooter()
    }
    



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Parse model
extension HomeCollectionView {
    public func parseModels(data: [ModelItem], start: Int, className: String) {
        if className == self.className {//同一个界面
            if start == 0 {
                self.modelArray.removeAll()
                self.modelArray = data
            }else {
                self.modelArray += data
            }
            
        }else {//不同界面
            self.modelArray.removeAll()
            self.modelArray = data
        }
        self.className = className
        collectionView.reloadData()
    }
}

//MARK: - 界面刷新
extension HomeCollectionView {
    func addRefreshHeader() {
        let header = MJRefreshStateHeader.init {
            self.headerRefresh()
        }
        // 隐藏时间
        header?.lastUpdatedTimeLabel.isHidden = false;
        // 隐藏状态
        header?.stateLabel.isHidden = false;
        // 马上进入刷新状态
        //        header?.beginRefreshing()
        // 设置header
        self.collectionView.mj_header = header
    }
    
    
    
    func addLoadMoreFooter() {
        let footer = MJRefreshAutoNormalFooter.init {
            self.footerLoadMore()
        }
        self.collectionView.mj_footer = footer
    }
    
    func headerRefresh() {
        self.headerRefreshBlock()
    }
    
    func footerLoadMore() {
        self.footerLoadMoreBlock()
        
    }
    
    func endRefreshing() {
        collectionView.mj_header.endRefreshing()
        collectionView.mj_footer.endRefreshing()
    }
}

//MARK: - UICollectionView代理方法
extension HomeCollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    @objc(numberOfSectionsInCollectionView:) func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let modelItem = self.modelArray[indexPath.row]
        if indexPath.row == 0 {//首张图
            let identifier = "HeadCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HeadCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }else if modelItem.media?.isEmpty == true {//没有图片时
            let identifier = "NoImageCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NoImageCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }else if modelItem.source == "视频" {//视频类型
            let identifier = "VideoCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! VideoCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }else if modelItem.abstract_medias?.count != 0 {//三张图片类型
            let identifier = "AbstractMediasCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AbstractMediasCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
            
        }else {//左侧图片类型
            let identifier = "NormalCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! NormalCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }
        
        
        
    }
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let modelItem = self.modelArray[indexPath.row]
        if indexPath.row == 0 {//首张图
            return CGSize(width: self.frame.size.width, height: 200)
        }else if modelItem.media?.isEmpty == true {//没有图片时
            return CGSize(width: self.frame.size.width, height: 100)
        }else if modelItem.source == "视频" {//视频类型
            return CGSize(width: self.frame.size.width, height: 250)
        }else if modelItem.abstract_medias?.count != 0 {//三张图片类型
            return CGSize(width: self.frame.size.width, height: 130)
        }else {//左侧图片类型
            return CGSize(width: self.frame.size.width, height: 90)
        }
        
    }

    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = didSelectItemAtBlock {
            block(self.modelArray[indexPath.row])
        }
        
    }
}
