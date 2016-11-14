//
//  HJExpandSection.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit

class HJExpandSection: UIView, UITableViewDelegate, UITableViewDataSource {
    
    //点击section时界面跳转
//    typealias SectionDidClickBlock = () -> Void
//    var sectionDidClickBlock: SectionDidClickBlock?
    
    //进入登录界面
    typealias ShowLoginPageBlock = () -> Void
    var showLoginPageBlock: ShowLoginPageBlock?

    var menuHeaderView: HJMenuHeaderView!
    var tableView: UITableView!
    let Identifier: String = "cell"
    var modelArray: [LeftMenuItem]! {
        didSet {
            
            tableView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        tableView.sectionFooterHeight = 0
        self.addSubview(tableView)

        
        tableView.register(UINib.init(nibName: "HJMenuExpandCell", bundle: nil), forCellReuseIdentifier: Identifier)

        

        
        //headerView
        let insets = UIEdgeInsetsMake(200, 0, 50, 0)
        tableView.contentInset = insets
        menuHeaderView = HJMenuHeaderView(frame: CGRect.init(x: 0, y: -200, width: frame.size.width, height: 200))
        tableView.addSubview(menuHeaderView)
        menuHeaderView.showLoginPageBlock = {() in
            if let block = self.showLoginPageBlock {
                block()
            }
        }
        

        
    }
    
    
    //MARK: - Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuItem = modelArray[section]
        if menuItem.isOpened == false {
            return 0
        }
        return (modelArray[section].items?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier) as! HJMenuExpandCell
        cell.menuSubItem = modelArray[indexPath.section].items?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HJSectionView(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        view.leftModel = modelArray[section]

        view.indicatorDidClickBlock = {() in //界面展开
            tableView.reloadData()
        }
        return view
    }
    
    //点击cell后进入LeftSectionRowViewController界面
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LeftSectionRowViewController"), object: modelArray[indexPath.section].items?[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
