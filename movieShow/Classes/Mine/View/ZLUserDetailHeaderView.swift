//
//  ZLUserDetailHeaderView.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/22.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class ZLUserDetailHeaderView: UIView, NibLoadable {

    @IBOutlet weak var backgroundImageView: UIImageView!
    /// 背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    /// 用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    /// 发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    /// 关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    /// 推荐按钮
    @IBOutlet weak var recommendButton: AnimatableButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    /// 推荐 view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    /// 头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    /// 认证内容
    @IBOutlet weak var verifiedContentLabel: UILabel!
    /// 地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    /// 描述内容
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    /// 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    /// 粉丝数量
    @IBOutlet weak var followersCountLabel: UILabel!
    
    // 文章 视频 问答
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    /// 底层 view
    @IBOutlet weak var baseView: UIView!
    /// 底部的 ScrollView
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    weak var privorButton = UIButton()
    
    /// 指示条
    private lazy var indicatorView : UIView = {
        let indicatorView = UIView(frame: CGRect(x: (topTabButtonWidth - topTabindicatorWidth) * 0.5 , y: topTabView.height - 3, width: topTabindicatorWidth, height: topTabindicatorHeight))
        indicatorView.theme_backgroundColor = "colors.globalRedColor"
        return indicatorView
    }()
    
    
    var userDetail: ZLUserDetail? {
        didSet {
            backgroundImageView.kf.setImage(with: URL(string: (userDetail?.bg_img_url)!))
            avatarImageView.kf.setImage(with: URL(string: (userDetail?.avatar_url)!))
            vImageView.isHidden = !userDetail!.user_verified
            nameLabel.text = userDetail?.name
            // 认证
            if userDetail?.verified_agency == "" {
                verifiedAgencyLabelTop.constant = 0
                verifiedAgencyLabelHeight.constant = 0
            } else {
                verifiedAgencyLabel.text = userDetail!.verified_agency + ": "
                verifiedContentLabel.text = userDetail!.verified_content
            }
            
            //关注按钮
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail!.is_following ? UIColor.grayColor232() : UIColor.globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
            //地区按钮
            if userDetail!.area == "" {
                areaButton.isHidden = true
                areaButtonTop.constant = 0
                areaButtonHeight.constant = 0
            } else {
                areaButton.setTitle(userDetail!.area, for: .normal)
            }
            
            descriptionLabel.text = userDetail?.description
            if userDetail!.descriptionHeight > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }
            // 推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            //关注
            followersCountLabel.text = userDetail?.followersCount
            //粉丝
            followingsCountLabel.text = userDetail!.followingsCount
            
            
            if userDetail!.top_tab.count > 0 {
                //添加按钮和 tableView
                for (index ,topTab) in userDetail!.top_tab.enumerated() {
                    let button = UIButton(frame: CGRect(x: CGFloat(index) * topTabButtonWidth, y: 0, width: topTabButtonWidth, height: scrollView.frame.height))
                    button.setTitle(topTab.show_name, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.theme_setTitleColor("colors.black", forState: .normal)
                    button.theme_setTitleColor("colors.globalRedColor", forState: .selected)
                    button.addTarget(self, action: #selector(topTabButtonClicked), for: .touchUpInside)
                    scrollView.addSubview(button)
                    if index == 0 {
                        button.isSelected = true
                        privorButton = button
                    }
                    
                    if index == userDetail!.top_tab.count - 1 {
                        scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)

                    }
                }
            }
            scrollView.addSubview(indicatorView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        // 设置主题颜色
        theme_backgroundColor = "colors.cellBackgroundColor"
        baseView.theme_backgroundColor = "colors.cellBackgroundColor"
        avatarImageView.layer.theme_borderColor = "colors.cellBackgroundColor"
        topTabView.theme_backgroundColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMailButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followersCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followingsCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        verifiedAgencyLabel.theme_textColor = "colors.verifiedAgencyTextColor"
        verifiedContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImageView.theme_image = "images.toutiaohao"
        areaButton.theme_setTitleColor("colors.black", forState: .normal)
    }
    
    /// 接收到了关注按钮的点击
    @objc private func receivedConcernButtonClicked(notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let isSelected = userInfo["isSelected"] as! Bool
        concernButton.isSelected = isSelected
        concernButton.theme_backgroundColor = isSelected ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
        concernButton.borderColor = isSelected ? .grayColor232() : .globalRedColor()
        concernButton.borderWidth = isSelected ? 1 : 0
    }
    
    
   
    
    
    
}

/// 点击动作
extension ZLUserDetailHeaderView {
    /// 发私信
    @IBAction func sendMessageClick(_ sender: UIButton) {
    }
    
    /// topTab 按钮点击方法
    @objc func topTabButtonClicked(button: UIButton) {
        privorButton?.isSelected = false
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            self.indicatorView.centerX = button.centerX
        }) { (_) in
            self.privorButton = button
        }
        
    }
    
    /// 关注按钮
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        
        if sender.isSelected { //已关注  点击取消关注
            NetWorkTool.loadRelationUnfollow(userId: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.globalRedColor"
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                self.recommendButtonTrailing.constant = 0
                self.recommendButtonWidth.constant = 0
                self.recommendViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                })
            }
            
        } else { // 未关注  点击关注某个用户
            NetWorkTool.loadRelationFollow(userId: userDetail!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                sender.borderColor = .grayColor232()
                sender.borderWidth = 1
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 28.0
                self.recommendButtonTrailing.constant = 15.0
                self.recommendViewHeight.constant = 233
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                }, completion: { (_) in
                    //点击关注后  就会出现相关数据
                    NetWorkTool.loadRelationUserRecommend(userId: self.userDetail!.user_id, completionCallBack: { (userCards) in
                        
                    })
                })
                
            }
        }
    }
    
    /// 推荐关注按钮点击
    @IBAction func recommendButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        recommendViewHeight.constant = sender.isSelected ? 0 : 233.0
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        })
    }
    /// 展开按钮
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0
        descriptionLabelHeight.constant = userDetail!.descriptionHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        })
    }
}
