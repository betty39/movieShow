//
//  ZLMoreLoginViewController.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/19.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable

class ZLMoreLoginViewController:  AnimatableModalViewController{
    
    
    
    @IBOutlet weak var loginCloseButton: UIButton!
    /// 登录标题
    @IBOutlet weak var topLabel: UILabel!
    /// 手机View
    @IBOutlet weak var mobileView: AnimatableView!
    ///验证码View
    @IBOutlet weak var verificationView: AnimatableView!
    ///发送验证码View
    @IBOutlet weak var sendVerificationCodeView: UIView!
    ///找回密码View
    @IBOutlet weak var findPsdView: UIView!
    /// 发送验证码按钮
    @IBOutlet weak var sendVerificationBtn: UIButton!
    /// 找回密码按钮
    @IBOutlet weak var findPsdBtn: UIButton!
    /// 手机输入框
    @IBOutlet weak var mobileTextField: UITextField!
    /// 验证码输入框
    @IBOutlet weak var VerificationTextField: UITextField!
    /// 未注册
    @IBOutlet weak var middleTipLabel: UILabel!
     /// 进入头条
    @IBOutlet weak var entermovieShowButton: AnimatableButton!
    /// 阅读条款
    @IBOutlet weak var readLabel: UILabel!
    
    /// 阅读按钮
    @IBOutlet weak var readButton: UIButton!
    /// 账号密码登录
    @IBOutlet weak var loginModeButton: UIButton!
    
    @IBOutlet weak var weChatLoginBtn: UIButton!
    
    
    @IBOutlet weak var qqLoginBtn: UIButton!
    
    
    @IBOutlet weak var tianyiLoginBtn: UIButton!
    

    @IBOutlet weak var mailLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginModeButton.setTitle("免密码登录", for: .selected)
        setTheme()
       

    }
    
    /// 退出
    @IBAction func moreLoginCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 账号密码登录
    @IBAction func loginModeButton(_ sender: UIButton) {
        loginModeButton.isSelected = !sender.isSelected
        sendVerificationCodeView.isHidden = sender.isSelected
        findPsdBtn.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        VerificationTextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "账号密码登录" : "登录movieShow，为精彩而来"
        
    }
    

}


extension ZLMoreLoginViewController {
    /// 设置 夜间/白天 模式
    func setTheme() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        topLabel.theme_textColor = "colors.black"
        middleTipLabel.theme_textColor = "colors.cellRightTextColor"
        readLabel.theme_textColor = "colors.black"
        entermovieShowButton.theme_backgroundColor = "colors.enterToutiaoBackgroundColor"
        entermovieShowButton.theme_setTitleColor("colors.enterToutiaoTextColor", forState: .normal)
        readButton.theme_setImage("images.loginReadButton", forState: .normal)
        readButton.theme_setImage("images.loginReadButtonSelected", forState: .selected)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        verificationView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        loginCloseButton.theme_setImage("images.loginCloseButtonImage", forState: .normal)
        weChatLoginBtn.theme_setImage("images.moreLoginWechatButton", forState: .normal)
        qqLoginBtn.theme_setImage("images.moreLoginQQButton", forState: .normal)
        tianyiLoginBtn.theme_setImage("images.moreLoginTianyiButton", forState: .normal)
        mailLoginBtn.theme_setImage("images.moreLoginMailButton", forState: .normal)
    }
}
