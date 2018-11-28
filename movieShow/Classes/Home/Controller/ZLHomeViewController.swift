//
//  ZLHomeViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/9.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
fileprivate let kTitleViewH : CGFloat = 50

class ZLHomeViewController: UIViewController {
    var titles = ["热门", "社会", "科技", "旅游"]
    var cells = [[MovieListTitle]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        // 设置 UI 界面
        setUpUI()
    }

    // MARK:- 懒加载
    fileprivate lazy var pageTitleView: MovieTagView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: kTitleViewH)
        //titles = ["热门", "社会", "科技", "旅游"]
        let titleView = MovieTagView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    /**
    fileprivate lazy var pageContentView: MovieListView = {[weak self] in
        // 1. 确定内容 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: contentH)
        // 2. 确定所有控制器
        var childVcs = [UIViewController]()
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let string1 = "{\"moviename\": \"test1\", \"movieid\": \"1\", \"showyear\": \"2018\", \"typelist\": \"came\", \"picture\": \"http://image.tmdb.org/t/p/w185/e64sOI48hQXyru7naBFyssKFxVd.jpg\"}"
        let myAttent1 = MovieListTitle.deserialize(from: string1)
        var myAttents1 = [MovieListTitle]()
        myAttents1.append(myAttent1!)
        cells.append(myAttents1)
        let contentView = MovieListView(frame: contentFrame, childVcs: childVcs, parentVc: self, cells: cells)
        contentView.delegate = self
        return contentView
        }()
 **/
}


// MARK:- 设置 UI
extension ZLHomeViewController {
    fileprivate func setUpUI() {
        // 0. 不允许系统调整 scrollview 内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 添加 titleview
        view.addSubview(pageTitleView)
        
        // 2. 添加 contentview
        //view.addSubview(pageContentView)
    }
}

// MARK:- pageTitleViewDelegate
extension ZLHomeViewController: MovieTagViewDelegate {
    func pageTitleView(pageTitleView: MovieTagView, didSelectedIndex index: Int) {
        //pageContentView.scrollToIndex(index: index)
    }
}

// MARK:- pageContentViewDelegate
/**
extension ZLHomeViewController: MovieListViewDelegate {
    func pageContentView(pageContentView: MovieListView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgerss(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}
 */
