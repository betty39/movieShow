//
//  ZLMyCellModel.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import HandyJSON

struct ZLMyCellModel : HandyJSON{

    var grey_text: String = ""
    var text: String = ""
    var url: String = ""
    var tip_new: Int = 0
    var key: String = ""
    
}

struct ZLMyAttent : HandyJSON{
    var name: String = ""
    var url: String = ""
    var total_count: Int = 0
    var description: String = ""
    var time: String = ""
    var type: String = ""
    var icon: String = ""
    var userid: Int = 0
    var is_verify: Bool = false
    var media_id: Int = 0
    var tips: Bool = false
    var id: Int = 0
    var user_auth_info = UserAuthInfo()
}

struct ZLMiddleImage: HandyJSON {
    var type = ZLImageType.normal
    var height: CGFloat = 0
    
    var url_list = [ZLURLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: CGFloat = 0
    
    var uri: String = ""
    /// 宽高比
    var ratio: CGFloat? { return width / height }
    
}

/// 图片的类型
enum ZLImageType: Int, HandyJSONEnum {
    case normal = 1     // 一般图片
    case gif = 2        // gif 图
}

struct ZLImageList: HandyJSON {
    var type = ZLImageType.normal
    
    var height: CGFloat = 0
    
    var url_list = [ZLURLList]()
    
    var url: NSString = ""
    var urlString: String {
        guard url.hasSuffix(".webp") else { return url as String }
        return url.replacingCharacters(in: NSRange(location: url.length - 5, length: 5), with: ".png")
    }
    var width: CGFloat = 0
    
    var uri: String = ""
    /// 宽高比
    var ratio: CGFloat? { return width / height }
    
}


struct UserAuthInfo: HandyJSON {
    var auth_type: Int = 0
    var auth_info: String = ""
}
