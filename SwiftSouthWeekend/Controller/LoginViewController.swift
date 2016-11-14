//
//  LoginViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/31.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func dismissLoginController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
