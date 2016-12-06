//
//  RegionModel.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class RegionModel: NSObject {
    var id                : String?  /**< 区域id */
    var region_name       : String?  /**< 区域名称 */
    var content_code      : String?  /**< 区域编码 */
    var display_mode_code : String?  /**< 展示类型 */
    var region_type       : String?  /**< 区域类型 */
    var url               : String?  /**< 区域数据列表信息加载URL */
    var seq               : String?  /**< 排序字段 */
    
    var nav_list          : Array<Any> = []  /** 导航栏特有的 icon list */
    var dataSourceArr     : Array<Any> = []  /** 根据 url 请求到的 list 数据 */
}

class IconModel: NSObject {
    var id                : String?
    var name              : String?
    var code              : String?
}

