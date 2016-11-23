//
//  NewsModel.swift
//  CloudStudy
//
//  Created by pro on 2016/11/7.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsModel: BaseModel {

    var id : String?
    //新闻名称
    var name : String?
    //发布时间
    var publish_time : String?
    //新闻详情地址
    var url : String?
    //新闻摘要
    var Description : String?
    //新闻封面
    var cover : String?
    //浏览数
    var browse_count : String?
    
}
