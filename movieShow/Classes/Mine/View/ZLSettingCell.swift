//
//  ZLSettingCell.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/20.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import Kingfisher

class ZLSettingCell: UITableViewCell, RegisterCellFromNib {
    
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var subtitleConstraintHeight: NSLayoutConstraint!
    var setting = ZLSettingModel() {
        didSet {
            titleLabel.text = setting.title
            subtitleLabel.text = setting.subtitle
            rightTitleLabel.text = setting.rightTitle
            arrowImageView.isHidden = setting.isHiddenRightArraw
            switchView.isHidden = setting.isHiddenSwitch
            if !setting.isHiddenSubtitle {
                subtitleConstraintHeight.constant = 20
                layoutIfNeeded()
            }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black";
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImageView.theme_image = "images.cellRightArrow"
        bottomLine.theme_backgroundColor = "colors.separatorViewColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension ZLSettingCell {
    ///获取缓存
    func calculateDiskCashSize() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            // 转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            self.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        }
    }
    /// 清理缓存
    func clearCacheAlertController()  {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .destructive) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            self.rightTitleLabel.text = "0.00M"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// 设置字体大小
    func setupFontAlertController() {
        let fontAlertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            self.rightTitleLabel.text = "小"
        }
        let middleAction = UIAlertAction(title: "中", style: .destructive) { (_) in
            self.rightTitleLabel.text = "中"
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            self.rightTitleLabel.text = "大"
        }
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            self.rightTitleLabel.text = "特大"
        }
        
        fontAlertController.addAction(cancleAction)
        fontAlertController.addAction(smallAction)
        fontAlertController.addAction(middleAction)
        fontAlertController.addAction(bigAction)
        fontAlertController.addAction(largeAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(fontAlertController, animated: true, completion: nil)
    }
    
    /// 非 WiFi 网络流量
    func setupNetworkAlertController() {
        
        let alertController = UIAlertController(title: "非 WIFI 网络流量", message: nil
            , preferredStyle: .actionSheet)
        
        let cacleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最小效果(下载大图)", style: .default) { (_) in
            self.rightTitleLabel.text = "最小效果(下载大图)"
        }
        let betterAction = UIAlertAction(title: "较省流量(智能下图)", style: .default) { (_) in
            self.rightTitleLabel.text = "较省流量(智能下图)"
           
        }
        let lasetAction = UIAlertAction(title: "极省流量(智能下图)", style: .destructive) { (_) in
            self.rightTitleLabel.text = "极省流量(智能下图)"
        }
        
        alertController.addAction(cacleAction)
        alertController.addAction(bestAction)
        alertController.addAction(betterAction)
        alertController.addAction(lasetAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// 设置 非 WIFI 网络播放提醒
    func setupPlayNoticeAlertController() {
        let alertController = UIAlertController(title: "非 WIFI 网络播放提醒", message: nil
            , preferredStyle: .actionSheet)
        
        let cacleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            self.rightTitleLabel.text = "每次提醒"
        }
        let oneAction = UIAlertAction(title: "提醒一次", style: .destructive) { (_) in
            self.rightTitleLabel.text = "提醒一次"
            
        }
        
        
        alertController.addAction(cacleAction)
        alertController.addAction(everyAction)
        alertController.addAction(oneAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
}
