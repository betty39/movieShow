//
//  ZLOffLineDownLoadCell.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/20.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLOffLineDownLoadCell: UITableViewCell, RegisterCellFromNib {
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    
    var titles = ZLHomeNewsTitle () {
        didSet {
            titleLabel.text = titles.name
        }
    }
    
    
    /// 右边切换图片
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
