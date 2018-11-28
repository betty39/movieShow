//
//  ZLNoLoginHeaderView.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/14.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class ZLNoLoginHeaderView: UIView, NibLoadable {
    ///背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    /// 更多登录按钮
    @IBOutlet weak var moreButton: AnimatableButton!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let effactX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        effactX.minimumRelativeValue = -20
        effactX.maximumRelativeValue = 20
        //ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        /// 设置主题
        moreButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        
        
    }
    
}
