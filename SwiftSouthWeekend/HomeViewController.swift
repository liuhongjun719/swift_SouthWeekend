//
//  HomeViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/21.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SideMenuController
import ObjectMapper
import SwiftMessages

class HomeViewController: UIViewController, CAPSPageMenuDelegate {
    var aPageMenu : CAPSPageMenu?
    
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: ((self.navigationController?.navigationBar.frame.size.width)!-100)/2, y: ((self.navigationController?.navigationBar.frame.size.height)!-30)/2, width: 100, height: 30)
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.init(name: "Xingkai SC", size: 20)
        titleLabel.text = "南方周末"
        titleLabel.tag = 100
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "南方周末"

        self.view.backgroundColor = UIColor.init(red: 163/255.0, green: 0/255.0, blue: 15/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 163/255.0, green: 0/255.0, blue: 15/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor.white
        
        //let navigationTitleAttribute: NSDictionary = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont.init(name: "Xingkai SC", size: 20)]
        //self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : Any]

        self.addLeftButtonItem()
        self.addRightSearchButtonItem()
        
        

        var controllerArray : [UIViewController] = []
        
        let headViewController =  HeadViewController()
        headViewController.title = "头条"
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        controllerArray.append(headViewController)
        headViewController.didSelectItemAtBlock = {(modelItem) in
            //当左侧menu处于显示状态时，点击右侧cell时，隐藏左侧
            if self.revealViewController().frontViewPosition == .right {
                self.revealViewController().revealToggle(animated: true)
                return
            }
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        let investigateViewController = InvestigateViewController()
        investigateViewController.title = "调查"
        controllerArray.append(investigateViewController)
        investigateViewController.didSelectItemAtBlock = {(modelItem) in
            if self.revealViewController().frontViewPosition == .right {
                self.revealViewController().revealToggle(animated: true)
                return
            }
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        
        
        let situationViewController = SituationViewController()
        situationViewController.title = "时局"
        controllerArray.append(situationViewController)
        situationViewController.didSelectItemAtBlock = {(modelItem) in
            if self.revealViewController().frontViewPosition == .right {
                self.revealViewController().revealToggle(animated: true)
                return
            }
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        
        let videoViewController = VideoViewController()
        videoViewController.title = "视频"
        controllerArray.append(videoViewController)
        videoViewController.didSelectItemAtBlock = {(modelItem) in
            if self.revealViewController().frontViewPosition == .right {
                self.revealViewController().revealToggle(animated: true)
                return
            }
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        
        let southViewController = SouthViewController()
        southViewController.title = "Hi，南周"
        controllerArray.append(southViewController)
        southViewController.didSelectItemAtBlock = {(modelItem) in
            if self.revealViewController().frontViewPosition == .right {
                self.revealViewController().revealToggle(animated: true)
                return
            }
            let homeDetailViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
            homeDetailViewController.modelItem = modelItem
            self.navigationController?.pushViewController(homeDetailViewController, animated: true)
        }
        
        
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .menuMargin(20.0),
            .menuHeight(40.0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.5),
            .selectionIndicatorColor(UIColor.red),
            .selectedMenuItemLabelColor(UIColor.red),
            .unselectedMenuItemLabelColor(UIColor.lightGray),
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemSeparatorRoundEdges(true),
            .enableHorizontalBounce(true)
        ]

        
        
        aPageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64.0), pageMenuOptions: parameters)
        aPageMenu!.delegate = self
        //        aPageMenu?.enableHorizontalBounce = true
        self.view.addSubview(aPageMenu!.view)
        
        //注册通知,进入点击section后的界面
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushToSectionColumnPage), name: NSNotification.Name(rawValue: "LeftSectionColumnViewController"), object: nil)
        
        //注册通知,进入点击cell后的界面
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushToSectionRowPage), name: NSNotification.Name(rawValue: "LeftSectionRowViewController"), object: nil)
        
        //点击左侧menu底部的设置，进入设置界面
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushToSettingPage), name: NSNotification.Name(rawValue: "HideLeftMenu"), object: nil)

        
        

    }
    
    func pushToSettingPage() {
        self.revealViewController().revealToggle(animated: false)
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    

    
    func showMessage() {
        //let viewCard = try! SwiftMessages.viewFromNib(named: "CardView", bundle: Bundle.main)
        //SwiftMessages.show(view: viewCard)
        
        
        let view = MessageView.viewFromNib(layout: .MessageView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: "Hello", body: "Nice to meet you!")
        view.buttonTapHandler = { _ in
            SwiftMessages.hide()
        }
        SwiftMessages.show(view: view)
 
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.dimMode = .color(color: UIColor.clear, interactive: true)
        config.interactiveHide = true
        config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: config, view: view)
        
        
        
        /*
        let view0: MessageView = try! SwiftMessages.viewFromNib(named: "MessageView")
        view0.buttonTapHandler = { _ in
            SwiftMessages.hide()
        }
        SwiftMessages.show(view: view0)
        */
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - 针对导航的显示和隐藏
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - Left
    func addLeftButtonItem() {
        let revealController = self.revealViewController
        self.navigationController?.navigationBar.addGestureRecognizer(revealController().panGestureRecognizer())
        
        

        let leftButton = UIButton()
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        leftButton.setBackgroundImage(UIImage(named: "left_menu.png"), for: .normal)
        
        leftButton.addTarget(self, action: #selector(HomeViewController.showLeft), for: .touchUpInside)

        
        let revealButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = revealButtonItem;
    }
    
    func showLeft() {
        self.revealViewController().revealToggle(animated: true)
    }
    
    func addRightSearchButtonItem() {
        let revealController = self.revealViewController
        self.navigationController?.navigationBar.addGestureRecognizer(revealController().panGestureRecognizer())
        
        
        
        let rightButton = UIButton()
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        rightButton.setBackgroundImage(UIImage(named: "front_search.png"), for: .normal)
        
        rightButton.addTarget(self, action: #selector(HomeViewController.showSearchPage), for: .touchUpInside)
        
        let rightButtonItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func showSearchPage() {
        let searchResultViewController = SearchResultViewController()
        self.navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
    //MARK: - 注册通知,进入点击section后的界面
    func pushToSectionColumnPage(noti: Notification) {
        self.revealViewController().revealToggle(animated: false)
        let modelItem = noti.object as! LeftMenuItem
//        print("model--------:\(model.sectionName)")
        let leftSectionColumnViewController = LeftSectionColumnViewController()
        leftSectionColumnViewController.modelItem = modelItem
        self.navigationController?.pushViewController(leftSectionColumnViewController, animated: true)
        
    }
    
    func pushToSectionRowPage(noti: Notification) {
        self.revealViewController().revealToggle(animated: false)
        let modelItem = noti.object as! LeftMenuSubItem
        
        let leftSectionRowViewController = LeftSectionRowViewController()
        leftSectionRowViewController.modelItem = modelItem
        self.navigationController?.pushViewController(leftSectionRowViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(titleLabel)

    }

}








