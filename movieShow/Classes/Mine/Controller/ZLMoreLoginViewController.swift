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
    
    // 注册按钮
    @IBOutlet weak var registerbtn: UIButton!
    
    var sqlmannager:SQLiteManager!
    
    @IBOutlet weak var loginCloseButton: UIButton!
    
    // 登录按钮
    @IBOutlet weak var loginbtn: AnimatableButton!
    
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
    
    // 判断是否是登录状态
    var islogin = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VerificationTextField.isSecureTextEntry = true
        setTheme()
    }
      //点击登录
    @IBAction func loginclick(_ sender: Any) {
            let username:String = mobileTextField.text!
            let password:String = VerificationTextField.text!
            //let jsonString = "{\"id\":24,\"username\":\"user1\",\"password\":\"user1\"}"
            let jsonString = "{\"id\":24,\"username\":\""+username+"\",\"password\":\""+password+"\"}"
            guard let model = MovieUser.deserialize(from: jsonString) else {return}
            //与数据库建立连接
            sqlmannager = SQLiteManager()
        //第一次运行的时候,要建表user和movielike表
             sqlmannager.tableLampCreate()
             //sqlmannager.insert(model)
        sqlmannager.tablemovlike()

        if(islogin == true) {
            //登录
            if sqlmannager.islogin(model) == true {
                print("登录成功！")
                let userDefault = UserDefaults.standard
                userDefault.set(username, forKey: "username")
                //跳转
            }else{
                print("登录失败！")
                let alert = UIAlertController(title: "提示", message: "用户名或密码，请重新输入！", preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
                alert.addAction(btnOK)
                self.present(alert, animated: true, completion: nil)
            }
        } else{
            //注册
            //是否已存在
            if sqlmannager.exist(model) == true {
                print("注册失败！")
                let alert = UIAlertController(title: "用户注册", message: "用户已存在，请重新输入！", preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
                alert.addAction(btnOK)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                //插入a到数据库当中
                sqlmannager.insert(model)
                print("注册成功！")
                let alert = UIAlertController(title: "用户注册", message: "注册成功，请登录！", preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
                alert.addAction(btnOK)
                self.present(alert, animated: true, completion: nil)
                islogin = true
                self.topLabel.text = "登录"
                self.loginbtn.setTitle("登录", for: UIControl.State.normal)
                self.registerbtn.isHidden = false
            }
        }
        
        
        
        
    }
    /// 退出
    @IBAction func moreLoginCloseBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //注册按钮点击事件
    @IBAction func regbtnclick(_ sender: Any) {
        islogin = false
        self.topLabel.text = "注册"
        self.loginbtn.setTitle("注册", for: UIControl.State.normal)
        self.registerbtn.isHidden = true
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
