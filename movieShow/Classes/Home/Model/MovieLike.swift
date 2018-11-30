//
//  MovieLike.swift
//  movieShow
//
//  Created by 勤劳的蚊子 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import HandyJSON

struct MovieLike: HandyJSON {
    
    var id: Int = 0
    var username: String = ""
    var movieid: String = ""
    var title: String = ""
    var average: String = ""
    var imgmedium: String = ""
    var year: String = ""
}
