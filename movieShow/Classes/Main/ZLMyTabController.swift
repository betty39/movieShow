//
//  ZLMyTabController.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLMyTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        
        ///添加子控制器
        addChildViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayoOrNightChange), name: NSNotification.Name(rawValue: "dayoOrNightChange"), object: nil)
        
    }
    
    @objc func receiveDayoOrNightChange(notification: Notification) {
        let selected = notification.object as! Bool
        if selected { // 设置为夜间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setNightChildController(controller: childController, imageName: "home")
                case "未登录":
                    setNightChildController(controller: childController, imageName: "no_login")
                default:
                    break
                }
            }
        } else { // 设置为日间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setDayChildController(controller: childController, imageName: "home")
                case "未登录":
                    setDayChildController(controller: childController, imageName: "no_login")
                default:
                    break
                }
            }
        }
        
    }
    
    /// 设置夜间控制器
    private func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    /// 设置日间控制器
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
         print(tabBar.subviews)
    }
    ///添加子控制器
    private func addChildViewController() {
        setChild(ZLHomeViewController(), title: "首页", imageName: "home")
        setChild(ZLMineViewController(), title: "用户", imageName: "no_login")
        //tabbar 是 readonly 属性不能直接修改 通过KVC
        setValue(ZLMyTabBar(), forKey: "tabBar")
    }
    

    ///初始化子控制器
     func setChild(_ childController: UIViewController,title: String,imageName: String) {
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        } else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.title = title
        //添加导航控制器为 TabBar子控制器
        addChild(ZLMovieNavigationController(rootViewController: childController))
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
