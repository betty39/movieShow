//
//  ZLUserDetailBottomView.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/27.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

protocol UserDetailBottomViewDelegate: class {
    /// bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: ZLBottomTab)
}

class ZLUserDetailBottomView: UIView {

    weak var delegate: UserDetailBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var bottomTabs = [ZLBottomTab](){
        didSet{
            let buttonWidth = (screenWidth - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            for (index, bottomTab) in bottomTabs.enumerated() {
                // 按钮
                let button = UIButton(frame: CGRect(x: CGFloat(index) * (buttonWidth + 1), y: 0, width: buttonWidth, height: height))
                button.setTitle(bottomTab.name, for: .normal)
                button.tag = index
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.theme_setImage("images.tabbar-options", forState: .normal)
                button.addTarget(self, action: #selector(bottomTabButtonClicked), for: .touchUpInside)
                addSubview(button)
            }
        }
    }
    
    /// bottomTa 按钮点击事件
    @objc func bottomTabButtonClicked(button: UIButton) {
        delegate?.bottomView(clicked: button, bottomTab: bottomTabs[button.tag])
    }

}
