//
//  MyCollectionViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/9.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
import Kingfisher
fileprivate let kTitleViewH : CGFloat = 50

fileprivate let movieListCell = "MovieListCellID"

class MyCollectionViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var sections = [MovieListTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        // 设置 UI 界面
        setUpUI()
    }
    
    //初始化table
    fileprivate lazy var tableView: UITableView = {
        // 1. 确定内容 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: contentH)
        let table = UITableView(frame: contentFrame)
        table.zl_registerCell(cell: MovieLIstViewCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    /**
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
 **/
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as MovieLIstViewCell
        let section = sections[indexPath.section]
        let myCellModel = sections[indexPath.row]
        
        cell.nameText.text = myCellModel.moviename
        cell.yearText.text = myCellModel.showyear
        cell.rateText.text = "评分:"
        cell.imageVIEW.kf.setImage(with: URL(string:myCellModel.picture))
        return cell
    }
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /**
         if indexPath.section == 3 && indexPath.row == 1 { //跳转系统设置界面
         let systemSVC = ZLSystemSetupController()
         self.navigationController?.pushViewController(systemSVC, animated: true)
         
         }
         **/
    }
    
}


// MARK:- 设置 UI
extension MyCollectionViewController {
    fileprivate func setUpUI() {
        // 设置cells数据
        
        let string1 = "{\"moviename\": \"哈哈哈\", \"movieid\": \"2\", \"showyear\": \"2018\", \"typelist\": \"2018\", \"picture\": \"http://image.tmdb.org/t/p/w185/zMyfPUelumio3tiDKPffaUpsQTD.jpg\"}"
        let myAttent1 = MovieListTitle.deserialize(from: string1)
        sections.append(myAttent1!)
        sections.append(myAttent1!)
        // 2. 添加 contentview
        view.addSubview(tableView)
    }
}
