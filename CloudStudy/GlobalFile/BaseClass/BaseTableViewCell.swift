//
//  BaseTableViewCell.swift
//  CloudStudy
//
//  Created by pro on 2016/11/7.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

enum BaseTableViewCellType : Int {
    case Path = 0x00  //学习路径
    case Course       //课程
    case Survey       //调研
    case Subject      //专题
    case SubjectDetial//专题详情
    case Activity     //培训活动
    case Knowledge    //知识库
    case Examination  //考试
    case NewsPaper    //新闻
    case Gensee       //直播
}

class BaseTableViewCell: UITableViewCell {

    public var coverImg          : UIImageView?
    public var titleLabel        : UILabel?
    public var primaryInfoLabl   : UILabel?
    public var secondaryInfoLabl : UILabel?
    
    public func setupSubviewsWith(_ vistor:BaseTableViewCellType) {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
