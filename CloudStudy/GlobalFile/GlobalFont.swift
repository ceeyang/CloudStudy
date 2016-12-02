//
//  GlobalFont.swift
//  CloudStudy
//
//  Created by pro on 2016/11/4.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

/**
 *  公共视图字体
 */

let GlobalFont_NameLabelFont = UIDevice.current.isIphonePlus() ? UIFont(name: "Telugu Sangam MN", size:17) : UIFont(name: "Telugu Sangam MN", size:15)

let DefaultFont              =  UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:11) : UIFont(name: "Euphemia UCAS", size:10)   //默认字体

let DirectoryFont      =  UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:14) : UIFont(name: "Euphemia UCAS", size:12)

//适用于导航栏标题、一级标题（各模块名，正文标题）
let PublicMaxFont      = UIDevice.current.isIphonePlus() ? UIFont(name: "Telugu Sangam MN", size:19) : UIFont(name: "Telugu Sangam MN", size:17)

let PublicEighteenFont = UIDevice.current.isIphonePlus() ? UIFont(name: "Telugu Sangam MN", size:18) : UIFont(name: "Telugu Sangam MN", size:16)

//标题字体(适用于板块标题，列表cell内标题)
let PublicTitleFont    = UIDevice.current.isIphonePlus() ? UIFont(name: "Telugu Sangam MN", size:17) : UIFont(name: "Telugu Sangam MN", size:15)

//内容字体
let PublicContentFont  = UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:12) : UIFont(name: "Euphemia UCAS", size:11)

//适用于菜单，图文标题
let PublicItemFont     = UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:14) : UIFont(name: "Euphemia UCAS", size:13)

//用户名称字体
let PublicTwelveFont   = UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:12) : UIFont(name: "Euphemia UCAS", size:11)

//时间字体
let PublicTimeFont     = UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:11) : UIFont(name: "Euphemia UCAS", size:10)

//浏览数字体
let PublicCountFont    = UIDevice.current.isIphonePlus() ? UIFont(name: "Euphemia UCAS", size:11) : UIFont(name: "Euphemia UCAS", size:10)

let kNameFont                               = UIFont.systemFont(ofSize:15)
let kTimeFont                               = UIFont.systemFont(ofSize:11)
let kPublicContentFont                      = UIFont.systemFont(ofSize:15)
let kPraiseFont                             = UIFont.systemFont(ofSize:12)
let kReplyFont                              = UIFont.systemFont(ofSize:14)
