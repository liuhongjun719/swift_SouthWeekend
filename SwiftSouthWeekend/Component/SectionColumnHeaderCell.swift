//
//  SectionColumnHeaderCell.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class SectionColumnHeaderCell: UICollectionViewCell {
    //MARK: - Data
    var modelItem: ModelItem! {
        didSet {
            let url = "http://images.infzm.com/medias/" + ( modelItem.media?.replacingOccurrences(of: "\\", with: ""))!
            imageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
            name.text = modelItem.short_subject
            source.text = modelItem.source
            comment_count.text = String.init(format: "%i", modelItem.comment_count!)
            share_count.text = String.init(format: "%i", modelItem.share_count!)
            date.text = modelItem.modified?.getMomentFromNow()

            
         
            


            
            let name_size = modelItem.short_subject?.getStringSize(fontSize: 16, width: name.frame.size.width)
            name.snp.updateConstraints { (make) -> Void in
                make.height.equalTo((name_size?.height)!)
            }
            
            let source_size = modelItem.source?.getStringSize(fontSize: 10, width: source.frame.size.width)
            source.snp.updateConstraints { (make) -> Void in
                make.width.equalTo((source_size?.width)!+8)
                make.height.equalTo((source_size?.height)!+8)
            }
            

            //评论数为0时
            if modelItem.comment_count == 0 {//评论数为0时，隐藏评论图标和数目
                comment_count.text = ""
                comment_imageView.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo(1)
                }
                comment_count.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo(1).priority(600)
                }
                //如果评论数目为0，将右侧分享图标左侧的offset设置成5，缩小source和share_imageView之间的间距
                share_imageView.snp.updateConstraints { (make) -> Void in
                    make.left.equalTo(comment_count.snp.right).offset(5)
                }
                
            }else {
                let comment_size = String.init(format: "%i", modelItem.comment_count!).getStringSize(fontSize: 10, width: comment_count.frame.size.width)
                comment_count.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo((comment_size.width)).priority(600)
                }
            }
            
            //分享数为0时
            if modelItem.share_count == 0 {//分享数为0时，隐藏分享图标和数目
                share_count.text = ""
                share_imageView.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo(1)
                }
                share_count.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo(1).priority(600)
                }
                
            }else {
                let share_size = String.init(format: "%i", modelItem.share_count!).getStringSize(fontSize: 10, width: share_count.frame.size.width)
                share_count.snp.updateConstraints { (make) -> Void in
                    make.width.equalTo((share_size.width)).priority(600)
                }
            }
            
            

 
            
        }
    }
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(imageView)
        imageView.addSubview(overlayView)
        self.addSubview(name)
        self.addSubview(comment_count)
        self.addSubview(share_count)
        self.addSubview(comment_imageView)
        self.addSubview(share_imageView)
        self.addSubview(source)
        self.addSubview(date)
        
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
        }
        
        overlayView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(imageView)
        }
        
        
        
        
        date.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-13)
            make.left.equalTo(self).offset(10)
            make.height.equalTo(10)
            make.width.equalTo(20).priority(600)
        }
        
        comment_imageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(date)
            make.left.equalTo(date.snp.right).offset(5)
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        
        comment_count.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(date)
            make.left.equalTo(comment_imageView.snp.right).offset(2)
            make.height.equalTo(10)
            make.width.equalTo(20).priority(600)
        }
        
        share_imageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(date)
            make.left.equalTo(comment_count.snp.right).offset(10)
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        
        share_count.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(date)
            make.left.equalTo(share_imageView.snp.right).offset(2)
            make.height.equalTo(10)
            make.width.equalTo(20).priority(600)
        }
        
        name.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(date.snp.top).offset(-5)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(40)
            make.left.equalTo(date)
        }
        
        source.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(name.snp.top).offset(-10)
            make.left.equalTo(date)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        layoutIfNeeded()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Component
    lazy var imageView: UIImageView =  {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.white
        name.numberOfLines = 2
        name.font = UIFont.systemFont(ofSize: 16)
        name.sizeToFit()
        return name
    }()
    
    lazy var source: UILabel = {
        let source = UILabel()
        source.backgroundColor = UIColor.init(red: 150/255.0, green: 74/255.0, blue: 80/255.0, alpha: 1.0)
        source.textColor = UIColor.white
        source.textAlignment = .center
        source.font = UIFont.systemFont(ofSize: 10)
        return source
    }()
    
    lazy var comment_imageView: UIImageView =  {
        let comment_imageView = UIImageView()
        comment_imageView.image = UIImage(named: "comment")
        return comment_imageView
    }()
    
    lazy var comment_count: UILabel = {
        let comment_count = UILabel()
        comment_count.font = UIFont.systemFont(ofSize: 10)
        comment_count.textColor = UIColor.white
        return comment_count
    }()
    
    lazy var share_imageView: UIImageView =  {
        let share_imageView = UIImageView()
        share_imageView.image = UIImage(named: "share")
        return share_imageView
    }()
    
    lazy var share_count: UILabel = {
        let share_count = UILabel()
        share_count.font = UIFont.systemFont(ofSize: 10)
        share_count.textColor = UIColor.white
        return share_count
    }()
    
    
    lazy var date: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 10)
        date.textColor = UIColor.white
        date.textAlignment = .left
        return date
    }()
    
    lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.3
        return overlayView
    }()
    
}
