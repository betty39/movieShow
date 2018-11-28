//
//  ZLMyTabBar.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/13.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit

class ZLMyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
       theme_tintColor = "colors.tabbarTintColor"
       theme_barTintColor = "colors.cellBackgroundColor"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //当前tabbar 宽度和高度
        let width = frame.width
        let height: CGFloat = 49
        
        //设置其他按钮frame
        let buttonW = width * 0.5
        let buttonH = height
        let buttonY: CGFloat = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){ continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
        
    }
    
}
