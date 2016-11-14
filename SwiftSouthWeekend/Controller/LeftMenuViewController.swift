//
//  LeftMenuViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/26.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SideMenuController
import ObjectMapper


class LeftMenuViewController: UIViewController {
    var tableView: UITableView!
    var dataArray: [String]!
    var expandSection: HJExpandSection!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        expandSection = HJExpandSection(frame: CGRect.init(x: 0, y: 0, width: 280, height: self.view.frame.size.height))
        self.view.addSubview(expandSection)
        expandSection.showLoginPageBlock = {() in
            let loginViewController = LoginViewController()
            self.present(loginViewController, animated: true, completion: nil)
            
        }
        
        self.view.addSubview(menuBottomToolBar)

        self.getSectionData()

    }
    
    
    func getSectionData() {
        var array = [LeftMenuItem]()
        for dic  in MenuData.sharedInstance.dataArray {
            let result2 = Mapper<LeftMenuItem>().map(JSON: dic as! [String : Any])
            array.append(result2!)
        }
        expandSection.modelArray = array
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var menuBottomToolBar: HJMenuBottomToolBar = {
        let menuBottomToolBar =  HJMenuBottomToolBar(frame: CGRect.init(x: 0, y: self.view.frame.size.height-50, width: self.expandSection.frame.size.width, height: 50))
        return menuBottomToolBar
        
    }()
    


}
