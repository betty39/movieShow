//
//  Const.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/13.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
/// 屏幕宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let screenHeight = UIScreen.main.bounds.height

///服务器地址
//let BASE_URL = "http://lf.snssdk.com"
//let BASE_URL = "http://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"

let device_id: Int = 6096495334
let iid: Int = 5034850950


let zlMyHeaderViewHeight: CGFloat = 280

let isNight = "isNight"
///判断 iPhone X
let isIPhoneX: Bool = screenHeight == 812 ? true : false


let image1Width: CGFloat = screenWidth * 0.5
let image2Width: CGFloat = (screenWidth - 35) * 0.5
let image3Width: CGFloat = (screenWidth - 40) / 3


let UserDetailHeaderViewButtonClicked = "UserDetailHeaderViewButtonClicked"

/// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = screenWidth * 0.2
/// 关注的用户详情界面 topTab 的指示条的宽度 和 高度
let topTabindicatorWidth: CGFloat = 40
/// 关注界面 topTab 指示器 高度
let topTabindicatorHeight: CGFloat = 2
