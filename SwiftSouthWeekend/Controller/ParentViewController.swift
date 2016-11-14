//
//  ParentViewController.swift
//  LightningShopping
//
//  Created by 123456 on 16/10/14.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController, UIGestureRecognizerDelegate {

    var leftButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let navigationTitleAttribute: NSDictionary = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont.systemFont(ofSize: 16)]
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : Any]
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.view.backgroundColor =  UIColor.init(red: 163/255.0, green: 0/255.0, blue: 15/255.0, alpha: 1.0)
        let titleView = self.navigationController?.navigationBar.viewWithTag(100)
        titleView?.removeFromSuperview()//移除首页的“南方周末”
        
//        self.addGesture()
        self.addLeftButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 添加界面滑动手势
    func addGesture() {
        let target = self.navigationController?.interactivePopGestureRecognizer!.delegate
        let pan = UIPanGestureRecognizer(target:target,
                                         action:Selector(("handleNavigationTransition:")))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        //同时禁用系统原先的侧滑返回功能
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
        
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
    
    
    //MARK: -  返回按钮样式
    //MARK: - Left
    func addLeftButtonItem() {
        let revealController = self.revealViewController
        self.navigationController?.navigationBar.addGestureRecognizer(revealController().panGestureRecognizer())
        
        
        
        leftButton = UIButton()
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        leftButton.setBackgroundImage(UIImage(named: "nav_back.png"), for: .normal)
        
        leftButton.addTarget(self, action: #selector(ParentViewController.popViewController), for: .touchUpInside)
        
        
        let revealButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        
    }
    
    func popViewController() {
        self.navigationController!.popViewController(animated: true)
    }
    
    

    //MARK: - 针对导航的显示和隐藏
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.view.frame = CGRect.init(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    


}
