//
//  IntroduceViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/31.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import JazzHands
import SnapKit
import StyledPageControl

class IntroduceViewController: IFTTTAnimatedScrollViewController, IFTTTAnimatedScrollViewControllerDelegate {
    var pageControl: StyledPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        //set scrollview
        self.scrollView.contentSize = CGSize.init(width: 4 * self.view.frame.width, height: self.view.frame.height)

        self.scrollView.bounces = true;
        self.scrollView.isPagingEnabled = true;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.accessibilityLabel = "Intro";
        self.scrollView.accessibilityIdentifier = "Talk";
        
      
        
        self.delegate = self
        
        self.configureViews()
        self.configureAnimations()
        self.initPageControl()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initPageControl() {
        pageControl = StyledPageControl()
        
        pageControl.frame = CGRect.init(x: 0, y: self.view.bounds.size.height - 80, width: self.view.bounds.size.width, height: 14)
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageControlStyle = PageControlStyleDefault
        pageControl.coreNormalColor = UIColor.init(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1.0)
        pageControl.coreSelectedColor = UIColor.init(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        pageControl.gapWidth = 23
        pageControl.diameter = 14
        self.view.addSubview(pageControl)

    }
    

    
    func configureViews() {
        self.scrollView.addSubview(introduce_1)
        self.scrollView.addSubview(introduce_2)
        self.scrollView.addSubview(introduce_3)
        self.scrollView.addSubview(introduce_4)
        
        
        
        
    }
    
    
    func configureAnimations() {
    
    }
    
    
    
    //MARK: - Lazy component
    lazy var introduce_1: UIImageView = {
//        let introduce_1 = UIImageView.init(image: UIImage(named: "6_1.png"), highlightedImage: nil)
       let introduce_1 = UIImageView()
        introduce_1.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        introduce_1.image = UIImage(named: "6_1.png")
        return introduce_1
    }()
    
    
    lazy var introduce_2: UIImageView = {
        //        let introduce_2 = UIImageView.init(image: UIImage(named: "6_2.png"), highlightedImage: nil)
        let introduce_2 = UIImageView()
        introduce_2.frame = CGRect.init(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        introduce_2.image = UIImage(named: "6_2.png")
        return introduce_2
    }()
    
    lazy var introduce_3: UIImageView = {
        let introduce_3 = UIImageView()
        introduce_3.frame =  CGRect.init(x: self.view.frame.size.width*2, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        introduce_3.image = UIImage(named: "6_3.png")
//        let introduce_3 = UIImageView.init(image: UIImage(named: "6_2.png"), highlightedImage: nil)
        return introduce_3
    }()
    
    lazy var introduce_4: UIImageView = {
        let introduce_4 = UIImageView()
        introduce_4.frame =  CGRect.init(x: self.view.frame.size.width*3, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        introduce_4.image = UIImage(named: "6_4.png")
//        let introduce_4 = UIImageView.init(image: UIImage(named: "6_2.png"), highlightedImage: nil)
        return introduce_4
    }()
    
    
    //MARK: - IFTTTAnimatedScrollViewControllerDelegate
    func animatedScrollViewControllerDidScroll(toEnd animatedScrollViewController: IFTTTAnimatedScrollViewController!) {
        
    }
    //进入主界面
    func animatedScrollViewControllerDidEndDragging(atEnd animatedScrollViewController: IFTTTAnimatedScrollViewController!) {
        let app = (UIApplication.shared.delegate as! AppDelegate)
        app.showHomeController()  
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        var pageIndex = 0
        let pageWidth = scrollView.frame.size.width
        pageIndex = Int((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1        
        pageControl.currentPage = Int32(pageIndex)
    }
    
    
 

}
