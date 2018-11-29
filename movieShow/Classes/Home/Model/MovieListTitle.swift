//
//  MovieList.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/28.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import HandyJSON

struct MovieListTitle: HandyJSON {
    var moviename: String = ""
    var movieid: Int = 0
    var showyear: String = ""
    var typelist: String = ""
    var picture: String = ""
}

struct MovieListTitleTag: HandyJSON {
    var category: String = ""
    var categoryid: Int = 0
}
