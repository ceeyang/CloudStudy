//
//  DirectoryModel.swift
//  CloudStudy
//
//  Created by pro on 2016/11/29.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class DirectoryModel  : NSObject {
    
    var parent_id     : String?     //父目录id（如果为空，则说明该目录是根目录）
    var id            : String?     //当前目录id
    var rule_id       : String?     //查询该目录下所有内容的id
    var count         : String?     //该目录下的子目录数量
    var name          : String?     //该目录的名称
    var seq           : String?     //该目录的查询序列
    var level         : String?     //标示哪一级目录 1- 一级目录  2- 二级目录 3- 三级目录 4- 四级目录
    var subDirectorys : Array<Any> = [] //该目录的子目录数据

}
