//
//  ZLConcernCell.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import Kingfisher

class ZLConcernCell: UICollectionViewCell, RegisterCellFromNib {
    ///头像
    @IBOutlet weak var concernImageView: UIImageView!
    ///VIP
    @IBOutlet weak var concernAvatar: UIImageView!
    ///用户名
    @IBOutlet weak var concernLabel: UILabel!
    ///消息通知
    @IBOutlet weak var tipsBtn: UIButton!
    var zlMyConcern: ZLMyAttent? {
        didSet {
            concernImageView.kf.setImage(with: URL(string: (zlMyConcern?.icon)!))
            concernLabel.text = zlMyConcern?.name
            if let is_verify = zlMyConcern?.is_verify {
                concernAvatar.isHidden = !is_verify
            }
            if let tips = zlMyConcern?.tips {
                tipsBtn.isHidden = !tips
            }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        tipsBtn.layer.borderWidth = 1
        tipsBtn.layer.borderColor = UIColor.white.cgColor
        theme_backgroundColor = "colors.cellBackgroundColor"
        concernLabel.theme_textColor = "colors.black"
    }

}
