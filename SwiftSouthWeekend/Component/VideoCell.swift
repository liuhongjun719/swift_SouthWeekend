//
//  VideoCell.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/25.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class VideoCell: UICollectionViewCell {
    
    
    var modelItem: ModelItem! {
        didSet {
            let url = "http://images.infzm.com/medias/" + ( modelItem.media?.replacingOccurrences(of: "\\", with: ""))!
            firstImageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
            
            name.text = modelItem.short_subject
            source.text = modelItem.source
            comment_count.text = String.init(format: "%i", modelItem.comment_count!)
            share_count.text = String.init(format: "%i", modelItem.share_count!)
            
            date.text = modelItem.modified?.getMomentFromNow()

            
            
            let source_size = modelItem.source?.getStringSize(fontSize: 10, width: source.frame.size.width)
            source.snp.updateConstraints { (make) -> Void in
                make.width.equalTo((source_size?.width)!).priority(600)
                
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(firstImageView)
        self.addSubview(name)
        self.addSubview(comment_count)
        self.addSubview(share_count)
        self.addSubview(sepratorLine)
        self.addSubview(comment_imageView)
        self.addSubview(share_imageView)
        self.addSubview(source)
        self.addSubview(date)
        firstImageView.addSubview(playImage)
        
        
        
        sepratorLine.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
        
        source.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(sepratorLine.snp.top).offset(-10)
            make.left.equalTo(sepratorLine)
            make.height.equalTo(10)
            make.width.equalTo(150).priority(600)
        }
        
        comment_imageView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source)
            make.left.equalTo(source.snp.right).offset(5)
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        
        comment_count.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source)
            make.left.equalTo(comment_imageView.snp.right).offset(2)
            make.height.equalTo(10)
            make.width.equalTo(100).priority(600)
        }
        
        share_imageView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source)
            make.left.equalTo(comment_count.snp.right).offset(10)
            make.height.equalTo(10)
            make.width.equalTo(10)
        }
        
        share_count.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source)
            make.left.equalTo(share_imageView.snp.right).offset(2)
            make.height.equalTo(10)
            make.width.equalTo(100).priority(600)
        }
        
        date.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source)
            make.right.equalTo(sepratorLine.snp.right)
            make.height.equalTo(10)
            make.left.equalTo(share_count.snp.right).offset(15)
        }
        
        
        name.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(source.snp.top).offset(-5)
            make.height.equalTo(20)
            make.left.right.equalTo(sepratorLine)
        }
        
        firstImageView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(name.snp.top).offset(-5)
            make.top.equalTo(self).offset(15)
            make.left.right.equalTo(sepratorLine)
        
        }
        
        playImage.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(firstImageView)
            make.width.height.equalTo(66)
        }
        

        
        
        layoutIfNeeded()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Component
    
    lazy var firstImageView: UIImageView = {
        let firstImageView = UIImageView()
        return firstImageView
    }()

    lazy var name: UILabel = {
        let name = UILabel()
        name.numberOfLines = 2
        name.font = UIFont.systemFont(ofSize: 15)
        name.sizeToFit()
        return name
    }()
    
    lazy var source: UILabel = {
        let source = UILabel()
        source.textColor = UIColor.init(red: 91/255.0, green: 91/255.0, blue: 91/255.0, alpha: 1.0)
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
        comment_count.textColor = UIColor.init(red: 91/255.0, green: 91/255.0, blue: 91/255.0, alpha: 1.0)
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
        share_count.textColor = UIColor.init(red: 91/255.0, green: 91/255.0, blue: 91/255.0, alpha: 1.0)
        return share_count
    }()
    
    
    lazy var date: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 10)
        date.textColor = UIColor.init(red: 145/255.0, green: 145/255.0, blue: 145/255.0, alpha: 1.0)
        date.textAlignment = .right
        return date
    }()
    
    
    lazy var sepratorLine: UIView = {
        let sepratorLine = UIView()
        sepratorLine.backgroundColor = UIColor.init(red: 213/255.0, green: 213/255.0, blue: 213/255.0, alpha: 1.0)
        return sepratorLine
    }()
    
    
    lazy var playImage: UIImageView = {
       let playImage = UIImageView()
        playImage.image = UIImage(named: "video_play")
        return playImage
    }()
    
    
    
}
