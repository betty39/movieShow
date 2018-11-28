//
//  ZLMoreLoginViewController.swift
//  zhangyanlfNews
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
    /// 账户View
    @IBOutlet weak var mobileView: AnimatableView!
    ///密码View
    @IBOutlet weak var verificationView: AnimatableView!
    /// 账户输入框
    @IBOutlet weak var mobileTextField: UITextField!
    /// 密码输入框
    @IBOutlet weak var VerificationTextField: UITextField!
  
     /// 进入
    @IBOutlet weak var enterZhangyanlfNewsButton: AnimatableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    /// 退出
    @IBAction func moreLoginCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension ZLMoreLoginViewController {
    /// 设置 夜间/白天 模式
    func setTheme() {
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        topLabel.theme_textColor = "colors.black"
        enterZhangyanlfNewsButton.theme_backgroundColor = "colors.enterToutiaoBackgroundColor"
        enterZhangyanlfNewsButton.theme_setTitleColor("colors.enterToutiaoTextColor", forState: .normal)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        verificationView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        loginCloseButton.theme_setImage("images.loginCloseButtonImage", forState: .normal)
    }
}
