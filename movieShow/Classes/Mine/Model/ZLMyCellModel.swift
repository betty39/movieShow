//
//  ZLMyCellModel.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/14.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
import HandyJSON

struct ZLMyCellModel : HandyJSON{

    var grey_text: String = ""
    var text: String = ""
    var key: String = ""
    
}

/// 图片的类型
enum ZLImageType: Int, HandyJSONEnum {
    case normal = 1     // 一般图片
    case gif = 2        // gif 图
}

struct UserAuthInfo: HandyJSON {
    var auth_type: Int = 0
    var auth_info: String = ""
}
