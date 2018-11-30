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
        self.navigationItem.title = "我的收藏"
        // 设置 UI 界面
        setUpUI()
    }
    
    //初始化table
    fileprivate lazy var tableView: UITableView = {
        // 1. 确定内容 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: contentH)
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
        let section = sections[indexPath.section]
        let myCellModel = sections[indexPath.row]
        
        cell.nameText.text = myCellModel.moviename
        cell.yearText.text = myCellModel.showyear
        cell.rateText.text = ""
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
    
}


// MARK:- 设置 UI
extension MyCollectionViewController {
    fileprivate func setUpUI() {
        // 设置cells数据
        let userDefault = UserDefaults.standard
        let username:String = userDefault.string(forKey: "username")!
        var movieLikes = [MovieLike]()
        let sqlmannager = SQLiteManager()
        movieLikes = sqlmannager.searchlike(username)
        print(movieLikes)
        for data in movieLikes {
            let value = "{\"moviename\": \"" + data.title +  "\", \"movieid\": \"" + data.movieid +  "\", \"showyear\": \"" + data.year + "\", \"rate\": \"" + "" + "\", \"picture\": \"" + data.imgmedium + "\"}"
            sections.append(MovieListTitle.deserialize(from: value)!)
        }
        // 2. 添加 contentview
        view.addSubview(tableView)
    }
}
