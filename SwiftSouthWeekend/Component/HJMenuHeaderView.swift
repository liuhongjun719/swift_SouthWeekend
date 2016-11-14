//
//  HJMenuHeaderView.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/31.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit

class HJMenuHeaderView: UIView {
    
    //进入登录界面
    typealias ShowLoginPageBlock = () -> Void
    var showLoginPageBlock: ShowLoginPageBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(header)
        self.addSubview(loginText)
        self.addSubview(loginButton)
        self.addSubview(addImage)
        self.addSubview(selfCustom)
        
        
        header.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(self).offset(-50)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        loginText.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(header.snp.bottom)
            make.centerX.equalTo(header)
            make.width.equalTo(header)
            make.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(self)
        }
        
        
        addImage.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-10)
            make.width.height.equalTo(20)
            make.left.equalTo(self).offset(20)
        }
        
        selfCustom.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(addImage)
            make.height.equalTo(addImage)
            make.left.equalTo(addImage.snp.right).offset(10)
            make.right.equalTo(self)
        }
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 进入登录界面
    func showLoginPage() {
        if let block = showLoginPageBlock {
            block()
        }
    }
    
    
    lazy var header: UIImageView =  {
        let header = UIImageView()
        header.image = UIImage(named: "left_header.png")
        header.layer.cornerRadius = 25
        header.layer.masksToBounds = true
        return header
    }()

    
    lazy var loginText: UILabel  = {
        let login = UILabel()
        login.text = "登录"
        login.textAlignment = .center
        login.font = UIFont.systemFont(ofSize: 15)
        login.textColor = UIColor.init(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1.0)
        return login
    }()
    
    lazy var loginButton: UIButton  = {
       let loginButton = UIButton()
        loginButton.backgroundColor = UIColor.clear
        loginButton.addTarget(self, action: #selector(HJMenuHeaderView.showLoginPage), for: .touchUpInside)
        return loginButton
    }()
    
    
    lazy var addImage: UIImageView = {
       let addImage = UIImageView()
        addImage.image = UIImage(named: "left_add.png")
        return addImage
    }()
    
    lazy var selfCustom: UILabel = {
       let selfCustom = UILabel()
        selfCustom.text = "我定制"
        selfCustom.textColor = UIColor.init(red: 52/255.0, green: 52/255.0, blue: 52/255.0, alpha: 1.0)
        return selfCustom
    }()


}
