//
//  ZLHomeViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/9.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
fileprivate let kTitleViewH : CGFloat = 40

fileprivate let searchViewH : CGFloat = 35

fileprivate let movieListCell = "MovieListCellID"

class ZLHomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var titles = ["热门", "最新", "经典", "华语", "欧美", "动作", "喜剧", "爱情", "科幻"]
    var sections = [MovieListTitle]()
    var searchView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        // 设置 UI 界面
        let searchFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW / 3, height: searchViewH)
        searchView = UIButton(frame: searchFrame)
        searchView.setTitle("搜电影",  for: .normal)
        searchView.setTitleColor(UIColor.orange, for: .normal)
        searchView.backgroundColor = UIColor.white
        searchView.addTarget(self, action: #selector(searchClick), for: UIControl.Event.touchUpInside)
        searchView.setImage(UIImage(named:"search"), for: .normal)
        setUpUI()
    }
    
    @objc func searchClick(sender:UIButton) {
        let stodryboard = UIStoryboard(name: "MovieSearchViewController", bundle: nil)
        let detailController = stodryboard.instantiateViewController(withIdentifier: "MovieSearchViewController") as! MovieSearchViewController
        navigationController?.pushViewController(detailController, animated: true)
    }

    // MARK:- 懒加载
    fileprivate lazy var pageTitleView: MovieTagView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + searchViewH, width: kScreenW, height: kTitleViewH)
        let titleView = MovieTagView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    //初始化table
    fileprivate lazy var tableView: UITableView = {
        // 1. 确定内容 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH - kTitleViewH - searchViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH + searchViewH, width: kScreenW, height: contentH)
        let table = UITableView(frame: contentFrame)
        table.separatorStyle = .none
        table.zl_registerCell(cell: MovieLIstViewCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as MovieLIstViewCell
        //let section = sections[indexPath.section]
        let myCellModel = sections[indexPath.row]
        cell.nameText.text = myCellModel.moviename
        cell.rateText.text = "评分：" + myCellModel.rate
        cell.yearText.text = myCellModel.showyear
        cell.imageVIEW.kf.setImage(with: URL(string:myCellModel.picture))
        return cell
    }
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stodryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailController = stodryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailController, animated: true)
        detailController.detail = sections[indexPath.row]
    }
    
    //处理评分
    func transAverage(average:Double) -> String {
        return String(format: "%.1f", average/2)
        
    }
}


// MARK:- 设置 UI
extension ZLHomeViewController {
    fileprivate func setUpUI() {
        // 0. 不允许系统调整 scrollview 内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 添加 titleview
        view.addSubview(searchView)
        view.addSubview(pageTitleView)
        view.addSubview(tableView)
        
        // 设置cells数据
        
        NetWorkTool.loadHomeMovieData(genres: "热门") { (data) in
            self.sections = data
            self.tableView.reloadData()
            print(data)
        }
    }
}

// MARK:- pageTitleViewDelegate
extension ZLHomeViewController: MovieTagViewDelegate {
    func pageTitleView(pageTitleView: MovieTagView, didSelectedIndex index: Int) {
        NetWorkTool.loadHomeMovieData(genres: titles[index]) { (data) in
            self.sections = data
            self.tableView.reloadData()
        }
    }
}
