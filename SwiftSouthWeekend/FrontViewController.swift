//
//  FrontViewController.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/21.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FrontViewController: ButtonBarPagerTabStripViewController {
    
    let graySpotifyColor = UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)

    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor.purple
        settings.style.buttonBarItemBackgroundColor = UIColor.blue
//        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
//        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
//        settings.style.selectedBarHeight = 3.0
//        settings.style.buttonBarMinimumLineSpacing = 0
//        settings.style.buttonBarItemTitleColor = .orange
//        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
//        
//        settings.style.buttonBarLeftContentInset = 20
//        settings.style.buttonBarRightContentInset = 20
        
//        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
////            guard changeCurrentIndex == true else { return }
////            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
////            newCell?.label.textColor = .black
//            oldCell?.label.textColor = UIColor.red
//            newCell?.label.textColor = .black
////            newCell?.label.backgroundColor = UIColor.blue
//        }
//    }
        
        
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = UIColor(white: 1, alpha: 0.6)
            newCell?.label.textColor = .white
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        
        

    
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = TableChildExampleViewController(style: .plain, itemInfo: IndicatorInfo(title: "FRIENDS"))
        child_1.blackTheme = true
        let child_2 = TableChildExampleViewController(style: .plain, itemInfo: IndicatorInfo(title: "FEATURED"))
        child_2.blackTheme = true
        return [child_1, child_2]
//        return [FirstViewController(), SecondViewController()]
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
