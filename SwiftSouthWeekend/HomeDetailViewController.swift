//
//  HomeDetailViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/25.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SwiftMessages

class HomeDetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var bottomToolBar: HJBottomToolBar!
    
    var changeFontSizeTab: HJChangeFontSizeTab?
    
    var modelItem: ModelItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.webView.delegate = self
        var url = modelItem?.snsShare?["url"]
        if url == nil {
            url = ""
        }
        
        self.webView.loadRequest(.init(url: URL(string: url!)!))
        
        
        self.changeFontSizeTab = HJChangeFontSizeTab(frame: self.view.bounds)
       self.view.addSubview(self.changeFontSizeTab!)

        
        //点击tabItem
        bottomToolBar.tabBarItemDidClickBlock = {(tag) in
            if tag == 100 {
                self.navigationController!.popViewController(animated: true)
            }else if tag == 101 {//调整字体大小
                //self.showFontSizeView()

                self.changeFontSizeTab?.presentChangeFontView()
                
                self.changeFontSizeTab?.fontSizeDidSizeBlock = { (fontSize) in
                    switch fontSize {
                    case .small(let size):
                        self.changeFontSize(fontSize: size)
                    case .middle(let size):
                        self.changeFontSize(fontSize: size)
                    case .big(let size):
                        self.changeFontSize(fontSize: size)
                    default: break
                        
                    }
                }
                
                
                
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = animated
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = animated

    }
    
    
    //MARK: - Change font size
    func changeFontSize(fontSize: Float) {
        let string = String.init(format: "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'", fontSize)
        webView.stringByEvaluatingJavaScript(from: string)
    }
    
    
    func showFontSizeView() {
        let view0: MessageView = try! SwiftMessages.viewFromNib(named: "HJChangeFontSizeTab")

        SwiftMessages.show(view: view0)
    }

  
}


extension HomeDetailViewController {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.changeFontSize(fontSize: 140)
    }
}
