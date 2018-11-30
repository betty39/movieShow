//
//  MovieList.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/28.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import HandyJSON

struct MovieListTitle : HandyJSON{
    var moviename: String = ""
    var movieid: String = ""
    var showyear: String = ""
    var rate: String = ""
    var picture: String = ""
}

struct MovieListTitleTag : HandyJSON{
    var category: String = ""
    var categoryid: Int = 0
}

struct MovieList {
    var title: String
    var cover: String
}
