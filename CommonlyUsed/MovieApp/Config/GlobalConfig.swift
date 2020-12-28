//
//  GlobalConfig.swift
//  QKYC
//
//  Created by zhan on 2019/2/15.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit

///------------------------------适配-----------------------------------
let keyWindow = UIApplication.shared.keyWindow
/** 屏幕高度 */
let ScreenH = UIScreen.main.bounds.size.height
/** 屏幕宽度 */
let ScreenW = UIScreen.main.bounds.size.width

//判断是否iphoneX
let IS_IPHONEX :Bool =  ScreenH >= 812.0 ? true : false
let NAVBAR_HEIGHT :CGFloat = IS_IPHONEX ? 88.0 : 64.0 //顶部
let TABBAR_HEIGHT :CGFloat = IS_IPHONEX ? (49.0+34.0) : 49.0 //带tabrbar
let STATUSBAR_HEIGHT :CGFloat = IS_IPHONEX ? 44.0 : 20.0 ///状态栏
let MARGIN_BOTTOM :CGFloat = IS_IPHONEX ? 34.0 : 0.0 //底部
///最顶部
let MARGIN_TOP :CGFloat = IS_IPHONEX ? 24.0 : 0.0
let SCAL:CGFloat = IS_IPHONEX ? 1.1 : 1.0

///设定的 缩放比例
let PionWidth:CGFloat = ((ScreenW/375*1.0)*10).rounded()*0.1
let tempPionHeight:CGFloat = (ScreenH-STATUSBAR_HEIGHT-MARGIN_BOTTOM)/((667-20)*SCAL)
let PionHeight:CGFloat =  ((tempPionHeight)*10).rounded()*0.1





