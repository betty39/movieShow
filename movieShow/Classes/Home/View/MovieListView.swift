//
//  MovieListView.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/28.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

// MARK:- 定义唯一标识
fileprivate let contentCellID = "MovieListCellID"

// MARK:- 定义协议
protocol MovieListViewDelegate: class {
    func pageContentView(pageContentView: MovieListView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

class MovieListView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentVc: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    weak var delegate: MovieListViewDelegate?
    fileprivate var isForbidScrollDelegate: Bool = false
    var cells = [[MovieListTitle]]()
    
    // MARK:- 懒加载属性
    fileprivate lazy var tableView: UITableView = { [weak self] in
        // 1. 创建布局
        
        // 2. 创建 TableView
        let tableView = UITableView(frame: (self?.bounds)!)
        tableView.showsHorizontalScrollIndicator = false
        tableView.isPagingEnabled = true
        tableView.bounces = false
        tableView.scrollsToTop = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.zl_registerCell(cell: MovieListCell.self)
        
        return tableView
        }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?, cells: [[MovieListTitle]]) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.cells = cells
        super.init(frame: frame)
        
        // 设置 UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置 UI 界面
extension MovieListView {
    fileprivate func setUpUI() {
        // 2. 添加 TableView, 用于显示信息
        addSubview(tableView)
        tableView.frame = bounds
        
    }
}

// MARK:- UITableViewDataSource
extension MovieListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. 创建 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: contentCellID, for: indexPath)
        
        // 2. 设置 cell 数据
        /**
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        **/
        //cell.nameText.setText("dsfa")
        return cell
    }
}

// MARK:- UITableViewDelegate
extension MovieListView: UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0. 判断是否是点击
        if isForbidScrollDelegate { return }
        
        // 1. 定义要获取的内容
        var sourceIndex = 0
        var targetIndex = 0
        var progress: CGFloat = 0
        
        // 2. 获取进度
        let offsetX = scrollView.contentOffset.x
        let ratio = offsetX / scrollView.bounds.width
        progress = ratio - floor(ratio)
        
        // 3. 判断滑动的方向
        if offsetX > startOffsetX {     // 向左滑动
            sourceIndex = Int(offsetX / scrollView.bounds.width)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if offsetX - startOffsetX == scrollView.bounds.width || progress == 0{
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else  {                       // 向右滑动
            targetIndex = Int(offsetX / scrollView.bounds.width)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            progress = 1 - progress
        }
        
        // 4. 通知代理
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露方法
extension MovieListView {
    func scrollToIndex(index: Int) {
        // 1. 记录需要执行的代理方法
        isForbidScrollDelegate = true
        
        // 2. 滚到对应位置
        let offsetX = CGPoint(x: CGFloat(index) * tableView.bounds.width, y: 0)
        tableView.setContentOffset(offsetX, animated: false)
    }
}

