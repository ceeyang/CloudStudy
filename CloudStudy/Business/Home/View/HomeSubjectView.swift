//
//  HomeSubjectView.swift
//  CloudStudy
//
//  Created by pro on 2016/12/6.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeSubjectView: UIView {
    
    private var mCoverImg    : UIImageView!
    private var mTitleLabel  : UILabel!
    private var mStudyRecord : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //1. 封面图
        let coverImg = UIImageView(frame: CGRect(x:0, y:0, w:frame.size.width, h:frame.size.width * 128 / 192))
        coverImg.isUserInteractionEnabled = true
        coverImg.image = UIImage(named: "default_spceial")
        addSubview(coverImg)
        mCoverImg = coverImg
        
        //2. 标题
        let titleLabl = UILabel(frame: CGRect(x:0, y:coverImg.frame.maxY, w:frame.size.width, h:20))
        titleLabl.textColor = PublicTitleColor
        titleLabl.font = PublicItemFont
        titleLabl.textAlignment = .left
        titleLabl.backgroundColor = UIColor.clear
        addSubview(titleLabl)
        mTitleLabel = titleLabl
        //4.学习人数
        let studyRecord = UILabel(frame: CGRect(x:0, y:titleLabl.frame.maxY, w:frame.size.width, h:20))
        studyRecord.textColor = PublicContentColor
        studyRecord.font = PublicContentFont
        studyRecord.textAlignment = .left
        studyRecord.backgroundColor = UIColor.clear
        addSubview(studyRecord)
        mStudyRecord = studyRecord
    }
    
    public func configSubject(with model:HomeSubjectModel) {
    
        let cover  : String      = model.cover ?? ""
        if cover.isNotEmpty {
            mCoverImg.kf.setImage(with: URL(string:cover), placeholder: UIImage(named:"default_spceial"), options: nil, progressBlock: nil, completionHandler: nil)
        } else {
            mCoverImg.image = UIImage(named: "default_spceial")
        }
        mTitleLabel.text = model.title!
        let studyNumber : String = model.study_num ?? "0"
//        var studyNumber : String = "0"
//        if model.study_num != nil {
//            studyNumber  = model.study_num!
//        }
        let attributedStr  = NSMutableAttributedString(string: studyNumber + " learns")
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: kNavigationBarColor, range:NSRange(location: 0, length: studyNumber.length))
        mStudyRecord.attributedText = attributedStr
    }
    
    /** 样式为: 每个cell有4个items，可滚动，分页，每页显示4个items 时候重置frame */
    public func resetRectForSubviews() {
        let minImageWidth  = kHeightForMinImageWidth
        mCoverImg.frame    = CGRect(x:0, y:0, w:minImageWidth, h:frame.size.height)
        mTitleLabel.frame  = CGRect(x:mCoverImg.frame.maxX + 12, y:mCoverImg.frame.minY, w:frame.size.width - mCoverImg.frame.size.width - 12 - 10, h:20)
        mStudyRecord.frame = CGRect(x:mTitleLabel.frame.minX, y:mTitleLabel.frame.maxY,w:mTitleLabel.frame.width, h:20)
    }
}
