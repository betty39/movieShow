//
//  ZLMyOtherCell.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLMyOtherCell: UITableViewCell, RegisterCellFromNib{
    ///标题
    @IBOutlet weak var leftLabel: UILabel!
    ///副标题
    @IBOutlet weak var rightLabel: UILabel!
    ///箭头
    @IBOutlet weak var rigjtImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftLabel.theme_textColor = "colors.black";
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rigjtImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
