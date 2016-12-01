//
//  DocDetailModel.swift
//  CloudStudy
//
//  Created by pro on 2016/12/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class DocDetailModel: NSObject {
    var id                   : String?//知识id
    var url                  : String?//知识地址
    var name                 : String?//知识名称
    var kind                 : String?//知识分类
    var type                 : String?//文档类型
    var cover                : String?//封面
    var integral             : String?//下载积分
    var is_scored            : String?//是否已经评分
    var create_user          : String?//上传者
    var create_time          : String?//上传时间
    var Description          : String?//简介
    var is_favourited        : String?//知识是否被收藏
    var has_permission       : String?//是否有权限查看
    var create_user_id       : String?//上传操作id
    var composite_avg_score  : String?//评分
    
    var list                 : Array<Any> = []//标签数组
}
