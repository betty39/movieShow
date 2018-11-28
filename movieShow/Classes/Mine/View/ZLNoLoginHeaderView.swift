//
//  ZLNoLoginHeaderView.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class ZLNoLoginHeaderView: UIView, NibLoadable {
    ///背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    ///手机登录按钮
    @IBOutlet weak var mobileButton: UIButton!
    ///qq登录按钮
    @IBOutlet weak var qqButton: UIButton!
    ///微信登录按钮
    @IBOutlet weak var weChatButton: UIButton!
    ///新浪登录按钮
    @IBOutlet weak var sinaButton: UIButton!
    /// 更多登录按钮
    @IBOutlet weak var moreButton: AnimatableButton!
    ///收藏按钮
    @IBOutlet weak var collectButton: UIButton!
    ///历史按钮
    @IBOutlet weak var historyButton: UIButton!
    ///夜间按钮
    @IBOutlet weak var dayoOrNightButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var bottomView: UIView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayoOrNightButton.isSelected = UserDefaults.standard.bool(forKey: isNight)
        
        let effactX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        effactX.minimumRelativeValue = -20
        effactX.maximumRelativeValue = 20
        stackView.addMotionEffect(effactX)
        //ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        /// 设置主题
        mobileButton.theme_setImage("images.loginMobileButton", forState: .normal)
        weChatButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaButton.theme_setImage("images.loginSinaButton", forState: .normal)
        collectButton.theme_setImage("images.mineFavoriteButton", forState: .normal)
        historyButton.theme_setImage("images.mineHistoryButton", forState: .normal)
        dayoOrNightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        dayoOrNightButton.setTitle("夜间", for: .normal)
        dayoOrNightButton.setTitle("日间", for: .selected)
        moreButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        collectButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        dayoOrNightButton.theme_setTitleColor("colors.black", forState: .normal)
        bottomView.theme_backgroundColor = "colors.cellBackgroundColor"
        
        
    }
    
    @IBAction func dayoOrNightButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: isNight)
        MyTheme.switchNight(sender.isSelected)
        
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dayoOrNightChange"), object: sender.isSelected)
        
    }
    

}
