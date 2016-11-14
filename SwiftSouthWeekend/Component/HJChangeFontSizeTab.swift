//
//  HJChangeFontSizeTab.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/8.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit
class HJChangeFontSizeTab: UIView {
    
    public enum FontSizeType {
        case small(Float)
        case middle(Float)
        case big(Float)
    }
    

    
    typealias FontSizeDidSizeBlock = (_ fontSizeType: FontSizeType) -> Void
    var fontSizeDidSizeBlock: FontSizeDidSizeBlock?
    
    
    var selectedButton: UIButton?
    
    var bottomViewConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        self.backgroundColor = UIColor.clear
        self.addSubview(overlayView)
        self.addSubview(bottomView)
        bottomView.addSubview(leftTitle)
        bottomView.addSubview(changeFontSizeTab)
        
        changeFontSizeTab.addSubview(smallFontSizeTab)
        changeFontSizeTab.addSubview(middleFontSizeTab)
        changeFontSizeTab.addSubview(bigFontSizeTab)
        
        
        bottomView.addSubview(cancel)
        bottomView.addSubview(sepratorLine)
        selectedButton = bigFontSizeTab
        
        
        overlayView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self)
        }
        
        
        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(self)
            make.height.equalTo(self.frame.size.width/4)
            self.bottomViewConstraint = make.bottom.equalTo(self).offset(self.frame.size.width/4).constraint
        }
        
        changeFontSizeTab.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(bottomView).offset(-10)
            make.top.equalTo(bottomView).offset(10)
            make.width.equalTo(self.frame.size.width/2 - 50)
            make.height.equalTo(30)
        }
        
        leftTitle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(bottomView).offset(10)
            make.centerY.equalTo(changeFontSizeTab.snp.centerY)
            make.right.equalTo(changeFontSizeTab.snp.left)
            make.height.equalTo(30)
        }
        
        smallFontSizeTab.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(changeFontSizeTab)
            make.top.equalTo(changeFontSizeTab)
            make.width.equalTo((self.frame.size.width/2 - 50)/3)
            make.bottom.equalTo(changeFontSizeTab)
        }
        
        bigFontSizeTab.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(changeFontSizeTab)
            make.top.equalTo(changeFontSizeTab)
            make.width.equalTo((self.frame.size.width/2 - 50)/3)
            make.bottom.equalTo(changeFontSizeTab)
        }
        
        
        middleFontSizeTab.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(bigFontSizeTab.snp.left)
            make.top.equalTo(changeFontSizeTab)
            make.left.equalTo(smallFontSizeTab.snp.right)
            make.bottom.equalTo(changeFontSizeTab)
        }
        
        
        cancel.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(bottomView)
            make.height.equalTo(40)
        }
        
        
        sepratorLine.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(1)
            make.bottom.equalTo(cancel.snp.top)
            make.left.equalTo(bottomView).offset(10)
            make.right.equalTo(bottomView).offset(-10)
        }
        
        self.layoutIfNeeded()

        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI
    lazy var overlayView: UIButton = {
        let overlayView = UIButton()
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0
        overlayView.addTarget(self, action: #selector(HJChangeFontSizeTab.dismissChangeFontView), for: .touchUpInside)
        return overlayView
    }()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    lazy var leftTitle: UILabel = {
        let leftTitle = UILabel()
        leftTitle.text = "Aa 阅读字号"
        return leftTitle
    }()
    
    lazy var changeFontSizeTab: UIView = {
        let changeFontSizeTab = UIView()
        //changeFontSizeTab.layer.cornerRadius = 5
        //changeFontSizeTab.layer.borderColor = UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0).cgColor
        //changeFontSizeTab.layer.borderWidth = 1
        return changeFontSizeTab
    }()
    
    
    lazy var smallFontSizeTab: UIButton = {
        let smallFontSizeTab = UIButton()
        smallFontSizeTab.isSelected = false
        smallFontSizeTab.tag = 300
        smallFontSizeTab.backgroundColor = UIColor.white
        smallFontSizeTab.setTitle("小", for: .normal)
        smallFontSizeTab.setTitleColor(UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0), for: .normal)
        smallFontSizeTab.addTarget(self, action: #selector(HJChangeFontSizeTab.changeFontSize), for: .touchUpInside)
        return smallFontSizeTab
    }()
    
    lazy var middleFontSizeTab: UIButton = {
        let middleFontSizeTab = UIButton()
        middleFontSizeTab.isSelected = false
        middleFontSizeTab.tag = 301
        middleFontSizeTab.backgroundColor = UIColor.white
        middleFontSizeTab.setTitle("中", for: .normal)
        middleFontSizeTab.setTitleColor(UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0), for: .normal)
        middleFontSizeTab.addTarget(self, action: #selector(HJChangeFontSizeTab.changeFontSize), for: .touchUpInside)
        return middleFontSizeTab
    }()
    
    
    lazy var bigFontSizeTab: UIButton = {
        let bigFontSizeTab = UIButton()
        bigFontSizeTab.isSelected = true
        bigFontSizeTab.backgroundColor = UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0)
        bigFontSizeTab.tag = 302
        bigFontSizeTab.setTitle("大", for: .normal)
        bigFontSizeTab.setTitleColor(UIColor.white, for: .normal)
        bigFontSizeTab.addTarget(self, action: #selector(HJChangeFontSizeTab.changeFontSize), for: .touchUpInside)
        return bigFontSizeTab
    }()
    
    lazy var cancel: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("取消", for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancel.setTitleColor(UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0), for: .normal)
        cancel.addTarget(self, action: #selector(HJChangeFontSizeTab.dismissChangeFontView), for: .touchUpInside)
        return cancel
    }()
    
    lazy var sepratorLine: UIView = {
        let sepratorLine = UIView()
        sepratorLine.backgroundColor = UIColor.init(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0)
        return sepratorLine
    }()

    
    
    //MARK: - Action
    func changeFontSize(sender: UIButton) {
        guard selectedButton != sender else {
            return
        }
        //之前选中的按钮变成 白色背景 和 灰色文字
        selectedButton?.isSelected = false
        selectedButton?.setTitleColor(UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0), for: .normal)
        selectedButton?.backgroundColor = UIColor.white
        
        selectedButton = sender
        
        //新按钮变成 灰色背景 和 白色文字
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0)
        if let block = fontSizeDidSizeBlock {
            //block(sender.tag)
            switch sender.tag {
            case 300:
                block(.small(90))
            case 301:
                block(.middle(120))
            case 302:
                block(.big(140))
            default: break
                
            }
        }
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        changeFontSizeTab.clipViewCorner(corners: [.allCorners])
        smallFontSizeTab.clipButtonCorner(corners: [.topLeft, .bottomLeft])
        bigFontSizeTab.clipButtonCorner(corners: [.topRight, .bottomRight])
    }
    
    
    




}


//MAKR: - 控制bottomView的显示与隐藏
extension HJChangeFontSizeTab {
    //显示界面
    func presentChangeFontView() {
        self.isHidden = false
        // 告诉self约束需要更新
        self.setNeedsUpdateConstraints()
        // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        self.updateConstraintsIfNeeded()
        
        self.bottomViewConstraint?.update(offset: 0)
        self.overlayView.alpha = 0.5
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
            }) { (finish) in
        }
    }
    
    //隐藏界面
    func dismissChangeFontView() {
        self.bottomViewConstraint?.update(offset: self.frame.size.width/4)
        self.overlayView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            self.isHidden = true
        }
    }
    
}


extension UIView {
    func clipViewCorner(corners: UIRectCorner) {
        let corner: CGFloat = 5;
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners,
                                           cornerRadii: CGSize.init(width: corner, height: corner))
        shapeLayer.path =  bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIButton {
    func clipButtonCorner(corners: UIRectCorner) {
        let corner: CGFloat = 5;
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners,
                                           cornerRadii: CGSize.init(width: corner, height: corner))
        shapeLayer.path =  bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
 
        
    }

}

