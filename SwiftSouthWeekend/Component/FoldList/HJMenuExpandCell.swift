//
//  HJMenuExpandCell.swift
//  SwiftSouthWeekend
//
//  Created by 123456 on 16/10/27.
//  Copyright © 2016年 123456. All rights reserved.
//

import UIKit

class HJMenuExpandCell: UITableViewCell {
    
    
    
    var menuSubItem: LeftMenuSubItem! {
        didSet {
            title.text = menuSubItem.title
        }
    }

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        title.textColor = UIColor.init(red: 140/255.0, green: 140/255.0, blue: 140/255.0, alpha: 1.0)
        title.font = UIFont.systemFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
