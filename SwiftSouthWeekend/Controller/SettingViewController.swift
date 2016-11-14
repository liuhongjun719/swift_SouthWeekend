//
//  SettingViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/11/10.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import XLForm

class SettingViewController: XLFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleView = self.navigationController?.navigationBar.viewWithTag(100)
        titleView?.removeFromSuperview()//移除首页的“南方周末”
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }

    
    func initializeForm() {
        /*
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        form = XLFormDescriptor(title: "First")
        section = XLFormSectionDescriptor.formSection(withTitle: "")
        form.addFormSection(section)
        
        //row = XLFormRowDescriptor.init(tag: "tuisong", rowType: "推送通知") 
        row = XLFormRowDescriptor.init(tag: "tuisong", rowType: XLFormRowDescriptorTypeText, title: "推送通知")
        //row.cellConfigAtConfigure.setObject("Loacation", forKey: "textLabel.text" as NSCopying)
        row.value = "已开启"
        section.addFormRow(row)
        self.form = form
        */
        
        let form = XLFormDescriptor(title: "设置")
        
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        // Basic Information
        section = XLFormSectionDescriptor.formSection(withTitle: "")
        //section.footerTitle = "DynamicSelectorsFormViewController.swift"
        form.addFormSection(section)
        
        // Selector Push
        row = XLFormRowDescriptor(tag: "tuisong", rowType:XLFormRowDescriptorTypeSelectorPush, title:"推送通知")
        //row.action.viewControllerClass = UsersTableViewController.self
        row.value = "已开启"
        row.cellConfig.setObject(UIFont.systemFont(ofSize: 15), forKey: "textLabel.font" as NSCopying)


        section.addFormRow(row)
        
        self.form = form

        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
