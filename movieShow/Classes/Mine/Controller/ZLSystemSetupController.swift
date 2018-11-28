//
//  ZLSystemSetupController.swift
//  movieShow
//  系统设置 界面
//  Created by 张彦林 on 2018/11/19.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLSystemSetupController: UITableViewController {

    var sections = [[ZLSettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Table view data source
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLSettingCell
        let section = sections[indexPath.section]
        cell.setting = section[indexPath.row]
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.calculateDiskCashSize() //清除缓存
            case 2: cell.selectionStyle = .none //摘要
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! ZLSettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.clearCacheAlertController() //清除缓存
            case 1: cell.setupFontAlertController() //设置字体大小
            case 3: cell.setupNetworkAlertController()//设置非 WiFi 网络流量
            case 4: cell.setupPlayNoticeAlertController()//设置非 WiFi 网络播放提醒
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let offLDVC = ZLOfflineDownloadViewController()
                offLDVC.title = "离线下载"
                navigationController?.pushViewController(offLDVC, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}


extension ZLSystemSetupController {
    /// 设置UI
   fileprivate func setupUI() {
        tableView.zl_registerCell(cell: ZLSettingCell.self)
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        //加载plist 文件数据
        let path = Bundle.main.path(forResource: "settingPlist", ofType: ".plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        /*
        for dicts in cellPlist {
            let array = dicts as! [[String : Any]]
            var rows = [ZLSettingModel]()
            for dict in array {
                let row = ZLSettingModel.deserialize(from: dict as NSDictionary)
                rows.append(row!)
            }
            sections.append(rows)
        }
        */
        sections = cellPlist.compactMap({ section in
            (section as! [Any]).compactMap({ ZLSettingModel.deserialize(from: $0 as? [String: Any]) })
    })
    }
}


