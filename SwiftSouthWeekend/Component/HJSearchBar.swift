//
//  HJSearchBar.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/3.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit

class HJSearchBar: UIView, UITextFieldDelegate {
    
    //点击搜索时
    typealias TextFieldShouldSearchBlock = (_ searchText: String) -> Void
    var textFieldShouldSearchBlock: TextFieldShouldSearchBlock?
    
    //将要失去焦点时
    typealias TextFieldShouldBeginEditingBlock = () -> Void
    var textFieldShouldBeginEditingBlock: TextFieldShouldBeginEditingBlock?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = frame.size.height/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.init(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 0.5
        self.addSubview(searchImage)
        self.addSubview(searchTextField)
        
        
        searchImage.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self)
            make.left.equalTo(searchImage.snp.right)
            make.right.equalTo(self).offset(-10)
        }
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -UI
    open lazy var searchImage: UIImageView = {
        let searchImage = UIImageView()
        searchImage.image = UIImage(named: "search_icon.png")
        return searchImage
    }()
    

    open lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.placeholder = "搜索"
        searchTextField.font = UIFont.systemFont(ofSize: 13)
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
        searchTextField.textAlignment = .left
        return searchTextField
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let block = self.textFieldShouldSearchBlock {
            block(textField.text!)
        }
        return true
    }
    

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let block = self.textFieldShouldBeginEditingBlock {
            block()
        }
        return true
    }
    

    
    
    //点击空白区域失去焦点时，更新控件的约束
    open func updateComponentConstrainWhenResignResponder() {
        searchImage.snp.updateConstraints { (make) -> Void in
//            make.left.equalTo(self).offset(80)
//            make.left.equalTo(self.center.x)
        }
        searchTextField.textAlignment = .center

    }
    
    //获得焦点时
    open func updateComponentConstrainWhenGetResponder() {
        searchImage.snp.updateConstraints { (make) -> Void in
//            make.left.equalTo(self).offset(10)
        }
        searchTextField.textAlignment = .left
    }
    
    
    open func becomeResponder() {
        searchTextField.becomeFirstResponder()
        
    }
    
    

}
