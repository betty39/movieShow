//
//  SettingModel.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/20.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import HandyJSON

struct ZLSettingModel: HandyJSON {
    /*
     <key>title</key>
     <string>清理缓存</string>
     <key>subtitle</key>
     <string></string>
     <key>rightTitle</key>
     <string>0.0M</string>
     <key>isHiddenRightTitle</key>
     <false/>
     <key>isHiddenSubtitle</key>
     <true/>
     <key>isHiddenRightArraw</key>
     <true/>
     <key>isHiddenSwitch</key>
     <true/>
 */
    var title = ""
    var subtitle = ""
    var rightTitle = ""
    var isHiddenRightTitle = false
    var isHiddenSubtitle = true
    var isHiddenRightArraw = true
    var isHiddenSwitch = true
    
}


