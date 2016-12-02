//
//  DocListTableViewCell.swift
//  CloudStudy
//
//  Created by pro on 2016/11/28.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class DocListTableViewCell: UITableViewCell {

    fileprivate var mCoverImgView     : UIImageView?
    fileprivate var mTitleLabel       : UILabel?
    fileprivate var mDetailLabel      : UILabel?
    fileprivate var mStarView         : UIView?
    fileprivate var mPersonCountLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        let coverImg = UIImageView()
        contentView.addSubview(coverImg)
        coverImg.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(15)
            make.top.equalTo(contentView.snp.top).offset(15)
            make.size.equalTo(CGSize(width: 150, height: 100))
        }
        mCoverImgView = coverImg
        
        let nameLabel = UILabel()
        nameLabel.font = PublicTitleFont
        nameLabel.textColor = PublicTitleColor
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(coverImg.snp.right).offset(5)
            make.top.equalTo(coverImg)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.height.equalTo(20)
        }
        mTitleLabel = nameLabel
        
        let detailLabel = UILabel()
        detailLabel.textColor = PublicContentColor
        detailLabel.font = PublicContentFont
        detailLabel.textAlignment = .left
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(coverImg.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.left.equalTo(coverImg.snp.right).offset(5)
            make.height.equalTo(20)
        }
        mDetailLabel = detailLabel
        
        
        let countLabel = UILabel()
        countLabel.font = PublicContentFont
        countLabel.textAlignment = .right
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(20)
            make.bottom.equalTo(coverImg)
        }
        mPersonCountLabel = countLabel
        
        let separatorView = UIView()
        separatorView.backgroundColor = kAppBaseColor
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(1)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }
    
    public func configCellWith(_ model:DocFileModel,isDoc:Bool) {
        let url            = URL(string: model.cover!)
        var defaultImgName = ""
        var countStr       = ""
        var length         = 0
        if isDoc {
            defaultImgName = getDefaultImageNameWith(model.type!)
            countStr       = "浏览:" + model.browse_count!
            length         = (model.browse_count?.length)!
        } else {
            defaultImgName = "default_course"
            countStr       = "浏览:" + model.study_person_num!
            length         = (model.study_person_num?.length)!
        }
        
        mCoverImgView?.kf.setImage(with: url,placeholder: UIImage(named: defaultImgName),options: nil,progressBlock: nil,completionHandler: nil)
        mTitleLabel?.text  = model.name
        mDetailLabel?.text = (model.Description?.isBlank)! ? "暂无详细描述" : model.Description
        
        let attributedStr  = NSMutableAttributedString(string: countStr)
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range:NSRange(location: 3, length: length))
        mPersonCountLabel?.attributedText = attributedStr
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
