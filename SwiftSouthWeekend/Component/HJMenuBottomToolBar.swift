//
//  HJMenuBottomToolBar.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/31.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit

class HJMenuBottomToolBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(settingImage)
        self.addSubview(settingText)
        self.addSubview(collectImage)
        self.addSubview(collectText)
        self.addSubview(settingButton)
        self.addSubview(collectButton)
        
        
        settingImage.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        settingText.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(settingImage.snp.right).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(40)
            make.centerY.equalTo(settingImage)
        }
        
        
        collectText.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-30)
            make.height.equalTo(20)
            make.width.equalTo(40)
            make.centerY.equalTo(self)
        }
        
        collectImage.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(collectText.snp.left).offset(-5)
            make.width.height.equalTo(30)
            make.centerY.equalTo(collectText)
        }
        
        settingButton.snp.makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(self.frame.size.width/2)
        }
        
        
        collectButton.snp.makeConstraints { (make) -> Void in
            make.right.top.bottom.equalTo(self)
            //make.width.equalTo(settingButton)
            make.left.equalTo(settingButton.snp.right)
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var settingImage: UIImageView = {
        let settingImage = UIImageView()
        settingImage.image = UIImage(named: "left_setting.png")
        return settingImage
    }()
    
    lazy var settingText: UILabel = {
        let settingText = UILabel()
        settingText.text = "设置"
        settingText.font = UIFont.systemFont(ofSize: 16)
        settingText.textColor = UIColor.init(red: 144/255.0, green: 144/255.0, blue: 144/255.0, alpha: 1.0)
        return settingText
    }()
    
    lazy var collectImage: UIImageView = {
       let collectImage = UIImageView()
        collectImage.image = UIImage(named: "left_collect.png")
        return collectImage
    }()
    
    lazy var collectText: UILabel = {
        let collectText = UILabel()
        collectText.text = "收藏"
        collectText.font = UIFont.systemFont(ofSize: 16)
        collectText.textColor = UIColor.init(red: 144/255.0, green: 144/255.0, blue: 144/255.0, alpha: 1.0)
        return collectText
    }()
    
    lazy var settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.addTarget(self, action: #selector(HJMenuBottomToolBar.showSttingPage), for: .touchUpInside)
        return settingButton
    }()
    
    
    lazy var collectButton: UIButton = {
        let collectButton = UIButton()
        collectButton.addTarget(self, action: #selector(HJMenuBottomToolBar.showCollectPage), for: .touchUpInside)
        return collectButton
    }()
    
    //MAKR: - Action
    func showSttingPage() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HideLeftMenu"), object: nil)
    }
    
    func showCollectPage()  {
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBorderLine()
    }



}



extension HJMenuBottomToolBar {
    func addBorderLine() {
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath.init(rect: CGRect.init(x: 10, y: 0, width: self.bounds.size.width-20, height: 0.5))
        shapeLayer.path =  bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.init(red: 229/255.0, green: 228/255.0, blue: 229/255.0, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}
