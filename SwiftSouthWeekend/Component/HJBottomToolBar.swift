//
//  HJBottomToolBar.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/25.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit

class HJBottomToolBar: UIView {
    
    typealias TabBarItemDidClickBlock = (_ tag: Int) -> Void
    var tabBarItemDidClickBlock: TabBarItemDidClickBlock?

    
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("------init(frame: CGRect)-------")

        self.addSubview(back)
        self.addSubview(typeface)
        self.addSubview(collect)
        self.addSubview(support)
        self.addSubview(comment)
        self.addSubview(share)
        
        back.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        share.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        comment.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(share.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        support.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(comment.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        collect.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(support.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        typeface.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(collect.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        print("------coder aDecoder: NSCoder)-------")
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    
    override func awakeFromNib() {
        print("------awakeFromNib-------")
        self.backgroundColor = UIColor.white
        self.addSubview(back)
        self.addSubview(typeface)
        self.addSubview(collect)
        self.addSubview(support)
        self.addSubview(comment)
        self.addSubview(share)
        
        
        back.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        share.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        comment.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(share.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        support.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(comment.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        collect.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(support.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
        typeface.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(collect.snp.left).offset(-20)
            make.width.height.equalTo(back)
            make.centerY.equalTo(back)
        }
        
    }

    
    //MARK: - UI
    lazy var back: UIButton = {
        let back = UIButton()
        back.setBackgroundImage(UIImage(named: "detail_back"), for: .normal)
        back.tag = 100
        back.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return back
    }()
    
    lazy var typeface: UIButton = {
        let typeface = UIButton()
        typeface.setBackgroundImage(UIImage(named: "detail_typeface"), for: .normal)
        typeface.tag = 101
        typeface.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return typeface
    }()
    
    lazy var collect: UIButton = {
        let collect = UIButton()
        collect.setBackgroundImage(UIImage(named: "detail_collect"), for: .normal)
        collect.tag = 102
        collect.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return collect
    }()

    lazy var support: UIButton = {
        let support = UIButton()
        support.setBackgroundImage(UIImage(named: "detail_support"), for: .normal)
        support.tag = 103
        support.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return support
    }()
    
    lazy var comment: UIButton = {
        let comment = UIButton()
        comment.setBackgroundImage(UIImage(named: "detail_comment"), for: .normal)
        comment.tag = 104
        comment.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return comment
    }()
    
    lazy var share: UIButton = {
        let share = UIButton()
        share.setBackgroundImage(UIImage(named: "detail_share"), for: .normal)
        share.tag = 105
        share.addTarget(self, action: #selector(HJBottomToolBar.clickItem), for: .touchUpInside)
        return share
    }()
    
    
    
    //MARK: - Action
    func clickItem(sender: UIButton) {
        self.tabBarItemDidClickBlock!(sender.tag)
    }
    
}
