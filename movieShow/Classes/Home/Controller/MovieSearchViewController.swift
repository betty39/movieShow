//
//  MovieSearchViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/30.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var books = [MovieListTitle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "电影搜索"
        self.automaticallyAdjustsScrollViewInsets = false
        
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].moviename
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 点击跳转到详情
        let stodryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailController = stodryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailController, animated: true)
        detailController.detail = books[indexPath.row]
    }
    
}

extension MovieSearchViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        if let tag = searchController.searchBar.text {
            NetWorkTool.loadMovieSearchData(tag: tag) { (data) in
                self.books = data
                self.tableView.reloadData()
            }
        }
    }
}
