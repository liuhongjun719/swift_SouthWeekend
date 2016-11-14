//
//  CustomSideMenuViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/26.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SideMenuController

class CustomSideMenuViewController: SideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        performSegue(withIdentifier: "LeftMenuViewController", sender: nil)
        performSegue(withIdentifier: "HomeViewController", sender: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "left_menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 300
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        super.init(coder: aDecoder)
    }

}
