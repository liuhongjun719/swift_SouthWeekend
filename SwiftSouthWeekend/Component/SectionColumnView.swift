//
//  SectionColumnView.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import MJRefresh

class SectionColumnView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
        self.backgroundColor = UIColor.white
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical;
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout);
//        collectionView.backgroundColor = UIColor.init(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
        collectionView.backgroundColor = UIColor.white

        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.addSubview(collectionView)
        

        collectionView.register(SectionColumnHeaderCell.self, forCellWithReuseIdentifier: "SectionColumnHeaderCell")
        collectionView.register(SectionColumnCell.self, forCellWithReuseIdentifier: "SectionColumnCell")

        
        
        self.addRefreshHeader()
        self.addLoadMoreFooter()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    //MARK: - Parse model
    public func parseModels(data: [ModelItem], start: Int) {
        if start == 0 {
            self.modelArray.removeAll()
            self.modelArray = data
        }else {
            self.modelArray += data
        }
        
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
        
//        let modelItem = self.modelArray[indexPath.row]
        if indexPath.row == 0 {//首张图
            let identifier = "SectionColumnHeaderCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SectionColumnHeaderCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }else {//没有图片时
            let identifier = "SectionColumnCell";
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SectionColumnCell;
            cell.modelItem = self.modelArray[indexPath.row]
            return cell;
        }
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {//首张图
            return CGSize(width: self.frame.size.width, height: 200)
        }else {//首图下面
            return CGSize(width: (self.frame.size.width-5)/2, height: 250)
        }
    }
    
    
    
    
    
    
    
    
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtBlock(self.modelArray[indexPath.row])
        
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
    
    
    
    
    
}
