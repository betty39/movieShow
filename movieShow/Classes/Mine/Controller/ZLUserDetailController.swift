//
//  ZLUserDetailController.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/22.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLUserDetailController: UIViewController {

    /// 滚动试图
    @IBOutlet weak var scrollView: UIScrollView!
    /// 底部视图
    @IBOutlet weak var bottomView: UIView!
    /// 底部View高度
    @IBOutlet weak var BottomViewConstraintHeight: NSLayoutConstraint!
    
    /// 距离底部约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var userId: Int = 0
    
    var userDetail: ZLUserDetail?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        // 设置约束
        bottomConstraint.constant = isIPhoneX ? 34 : 0
        view.layoutIfNeeded()
        /// 获取用户详情
        NetWorkTool.loadUserDetail(userId: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            if self.userDetail?.bottom_tab.count == 0 {
                self.headerView.height = 979 - 34
                self.bottomConstraint.constant = 0
                self.BottomViewConstraintHeight.constant = 0
                self.view.layoutIfNeeded()
            } else {
                // 赋值到 bottomView 上
                self.bottomView.addSubview(self.myBottomView)
                self.myBottomView.bottomTabs = userDetail.bottom_tab
            }
        }

    }
    
    lazy var myBottomView : ZLUserDetailBottomView = {
        let myBottomView = ZLUserDetailBottomView()
        
        return myBottomView
    }()
    
    lazy var headerView : ZLUserDetailHeaderView = {
        let headerView = ZLUserDetailHeaderView.loadViewFromNib()
        
        return headerView
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}



