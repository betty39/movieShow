//
//  ZLHomeViewController.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        NetWorkTool.loadHomeTitleData { (homeTitles) in
            NewsTitleTable().insert(homeTitles)
        }
        
    }


}
