//
//  SearchCollectionView.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/3.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import MJRefresh

class SearchCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
    
    
    //空白view
    var blankBack: UIButton!
    typealias BlankDidClickedBlock = () -> Swift.Void
    var blankDidClickedBlock:BlankDidClickedBlock!
    
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
        
        collectionView.register(CatListHeaderReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier:"Header")

        
        collectionView.register(NormalCell.self, forCellWithReuseIdentifier: "NormalCell")
        collectionView.register(AbstractMediasCell.self, forCellWithReuseIdentifier: "AbstractMediasCell")
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.register(NoImageCell.self, forCellWithReuseIdentifier: "NoImageCell")
        collectionView.register(HeadCell.self, forCellWithReuseIdentifier: "HeadCell")
        
        self.addRefreshHeader()
        self.addLoadMoreFooter()
        
        blankBack = UIButton()
        blankBack.frame = frame
        blankBack.backgroundColor = UIColor.white
        blankBack.addTarget(self, action: #selector(SearchCollectionView.clickBlank), for: .touchUpInside)
        self.addSubview(blankBack)
    }
    
    //没有内容时，点击空白区域
    func clickBlank() {
        if let block = self.blankDidClickedBlock {
            block()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Parse model
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
    
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let modelItem = self.modelArray[indexPath.row]
        if modelItem.media?.isEmpty == true {//没有图片时
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resuableView: UICollectionReusableView?
        if kind == "UICollectionElementKindSectionHeader"  {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader" , withReuseIdentifier: "Header", for: indexPath) as? CatListHeaderReusableView
            view?.headerTitle.text = "文章"
            resuableView = view
        }
        return resuableView!
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let modelItem = self.modelArray[indexPath.row]
        if modelItem.media?.isEmpty == true {//没有图片时
            return CGSize(width: self.frame.size.width, height: 100)
        }else if modelItem.source == "视频" {//视频类型
            return CGSize(width: self.frame.size.width, height: 250)
        }else if modelItem.abstract_medias?.count != 0 {//三张图片类型
            return CGSize(width: self.frame.size.width, height: 130)
        }else {//左侧图片类型
            return CGSize(width: self.frame.size.width, height: 90)
        }
        
    }
    
    
    
    
    
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = didSelectItemAtBlock {
            block(self.modelArray[indexPath.row])
        }
        
    }
    

    
    //MARK: - 刷新
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
    
    //MARK: - 控制blankview
    open func removeBlankView() {
        blankBack.removeFromSuperview()
    }
    
    open func addBlankView() {
        self.addSubview(blankBack)
    }
    
    
    
    
    
}
