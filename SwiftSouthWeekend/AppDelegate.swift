//
//  AppDelegate.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/21.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SideMenuController
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SWRevealViewControllerDelegate {

    var window: UIWindow?
    var viewController: SWRevealViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame:UIScreen.main.bounds)
        self.window = window;

        choseInitialController()

        return true
    }
    
    //MARK: - 选择是进入引导页还是进入主界面
    func choseInitialController() {
        // 得到当前应用的版本号
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 取出之前保存的版本号
        let userDefaults = UserDefaults.standard
        let appVersion = userDefaults.string(forKey: "appVersion")
        
        // 如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
        if appVersion == nil || appVersion != currentAppVersion {
            showIntroduceController()
        }else {
            showHomeController()
        }
 
 
        
    }
    
    
    //TODO: -进入引导页
    func showIntroduceController() {
        let introduceViewController = IntroduceViewController()
        self.window?.rootViewController = introduceViewController
        self.window?.makeKeyAndVisible()
    }
    //TODO: -进入主界面
    func showHomeController() {
        let homeViewController = HomeViewController()
        let leftMenuViewController = LeftMenuViewController()
        
        let homeNavigationController = UINavigationController.init(rootViewController: homeViewController)
        
        let leftNavigationController = UINavigationController.init(rootViewController: leftMenuViewController)
        
        
        
        let mainRevealController = SWRevealViewController.init(rearViewController: leftNavigationController, frontViewController: homeNavigationController)
        mainRevealController?.rearViewRevealWidth = 280
        mainRevealController?.view.backgroundColor = UIColor.white
        
        mainRevealController?.delegate = self;
        self.viewController = mainRevealController;
        
        
        self.window?.rootViewController = self.viewController
        self.window?.makeKeyAndVisible()
    }

    
    //MARK: -Delegate
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

