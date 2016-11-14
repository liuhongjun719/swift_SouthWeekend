//
//  HJSectionView.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit


class HJSectionView: UIView {
    
    //点击section时界面跳转
//    typealias SectionDidClickBlock = (_ modelItem: LeftMenuItem) -> Void
//    var sectionDidClickBlock: SectionDidClickBlock?
    
    //点击section时展开或折叠，并刷新界面
    typealias IndicatorDidClickBlock = () -> Void
    var indicatorDidClickBlock: IndicatorDidClickBlock?
    
    var leftModel: LeftMenuItem! {
        didSet {
            imageView.image = UIImage(named: leftModel.image!)
            title.text = leftModel.sectionName
            
            if leftModel.isOpened == true {
                imageIndicator.image = UIImage(named: "left_up_indicator")
            }else {
                imageIndicator.image = UIImage(named: "left_down_indicator")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(title)
        self.addSubview(imageIndicator)
        self.addSubview(indicatorButton)
        self.addSubview(sectionButton)
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self)
        }
        
        imageIndicator.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-10)
            make.width.height.equalTo(20)
            make.centerY.equalTo(imageView)
        }
        
        title.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalTo(imageIndicator.snp.left)
            make.height.equalTo(20)
            make.centerY.equalTo(imageView)
        }
        
        indicatorButton.snp.makeConstraints { (make) -> Void in
            make.right.height.equalTo(self)
            make.width.equalTo(50)
        }
        
        sectionButton.snp.makeConstraints { (make) -> Void in
            make.left.height.equalTo(self)
            make.right.equalTo(indicatorButton.snp.left)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    //MARK: - UI
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var title: UILabel = {
       let title = UILabel()
        title.textColor = UIColor.init(red: 52/255.0, green: 52/255.0, blue: 52/255.0, alpha: 1.0)
        return title
    }()
    
    lazy var imageIndicator: UIImageView = {
        let imageIndicator = UIImageView()
        imageIndicator.image = UIImage(named: "left_down_indicator")
        return imageIndicator
    }()
    
    lazy var sectionButton: UIButton = {
       let sectionButton = UIButton()
        sectionButton.addTarget(self, action: #selector(HJSectionView.clickSection), for: .touchUpInside)
        return sectionButton
    }()
    
    lazy var indicatorButton: UIButton = {
        let indicatorButton = UIButton()
        indicatorButton.addTarget(self, action: #selector(HJSectionView.clickIndicator), for: .touchUpInside)
        return indicatorButton
    }()
    
    
    
    //MARK: - Action
    func clickSection(sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LeftSectionColumnViewController"), object: leftModel)
    }
    
    func clickIndicator(sender: UIButton) {
        if let block = indicatorDidClickBlock {
            leftModel.isOpened = !leftModel.isOpened!
            block()
        }
    }
    
    
    

    

}
