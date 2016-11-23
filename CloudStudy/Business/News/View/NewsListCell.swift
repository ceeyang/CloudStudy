////
////  NewsListCell.swift
////  CloudStudy
////
////  Created by pro on 2016/11/7.
////  Copyright © 2016年 daisy. All rights reserved.
////
//
//import UIKit
//
//
//class NewsListCell: UITableViewCell {
//    var mBackgroundImageView : UIImageView!
//    var mNewsCoverImageView  : UIImageView!
//    var mNewsTitleLabel      : UILabel!
//    var mNewsDescriptionLabel: UILabel!
//    var mNewsTimeLabel       : UILabel!
//    var mNewsPageViewsLabel  : UILabel!
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupUI() {
//        
//        // Config
//        mBackgroundImageView                  = UIImageView()
//        
//        mNewsCoverImageView                   = UIImageView()
//        mNewsCoverImageView.image             = UIImage(named: "default_news")
//        
//        mNewsTitleLabel                       = UILabel()
//        mNewsTitleLabel.font                  = PublicItemFont
//        mNewsTitleLabel.textColor             = PublicTitleColor
//        mNewsTitleLabel.backgroundColor       = UIColor.clear
//        mNewsTitleLabel.textAlignment         = .left
//        
//        mNewsDescriptionLabel                 = UILabel()
//        mNewsDescriptionLabel.font            = PublicContentFont
//        mNewsDescriptionLabel.textColor       = PublicContentColor
//        mNewsDescriptionLabel.backgroundColor = UIColor.clear
//        mNewsDescriptionLabel.textAlignment   = .left
//        mNewsDescriptionLabel.numberOfLines   = 0
//        mNewsDescriptionLabel.text            = LocalizedStringFromKey(key: "暂无")
//        
//        mNewsTimeLabel                        = UILabel()
//        mNewsTimeLabel.font                   = PublicCountFont
//        mNewsTimeLabel.textColor              = PublicContentColor
//        mNewsTimeLabel.backgroundColor        = UIColor.clear
//        mNewsTimeLabel.textAlignment          = .left
//        
//        mNewsPageViewsLabel                   = UILabel()
//        mNewsPageViewsLabel.font              = PublicCountFont
//        mNewsPageViewsLabel.textColor         = PublicContentColor
//        mNewsPageViewsLabel.backgroundColor   = UIColor.clear
//        mNewsPageViewsLabel.textAlignment     = .right
//        
//        
//        contentView.addSubview(mBackgroundImageView)
//        contentView.addSubview(mNewsCoverImageView)
//        contentView.addSubview(mNewsTitleLabel)
//        contentView.addSubview(mNewsDescriptionLabel)
//        contentView.addSubview(mNewsTimeLabel)
//        contentView.addSubview(mNewsPageViewsLabel)
//        
//        // Autolayout
//        mBackgroundImageView.snp.makeConstraints { (make) in
//            make.top.left.bottom.right.equalTo(0)
//        }
//        
//        mNewsCoverImageView.snp.makeConstraints { (make) in
//            make.left.equalTo(5)
//            make.top.equalTo(5)
//            make.size.equalTo(CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        }
//        
//        mNewsTitleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(defaultViewTopDistance)
//            make.left.equalTo(mNewsCoverImageView.snp_right).offset(defaultViewsDistance)
//            make.right.equalTo(mBackgroundImageView.snp_right).offset(-defaultViewSidesDistance)
//            make.height.equalTo(defaultTitleLabelHeight)
//        }
//        
//        mNewsTimeLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(mNewsCoverImageView.snp_right).offset(defaultViewsDistance)
//            make.bottom.equalTo(mBackgroundImageView.snp_bottom)
//            make.height.equalTo(defaultPageViesLabelHeight)
//            make.width.greaterThanOrEqualTo(100)
//        }
//        
//        mNewsPageViewsLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(mBackgroundImageView.snp_right).offset(-defaultViewsDistance * 2 )
//            make.bottom.equalTo(mBackgroundImageView.snp_bottom)
//            make.height.equalTo(defaultPageViesLabelHeight)
//            make.width.greaterThanOrEqualTo(100)
//        }
//        
//        mNewsDescriptionLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(mNewsCoverImageView.snp_right).offset(defaultViewsDistance)
//            make.top.equalTo(mNewsTitleLabel.snp_bottom)
//            make.right.equalTo(mBackgroundImageView.snp_right).offset(-defaultViewsDistance)
//            make.bottom.equalTo(mNewsTimeLabel.snp_top)
//        }
//    }
//    
//    func reloadCellDataWithModel(model:NewsModel) {
//        mNewsTitleLabel.text     = model.name
//        mNewsTimeLabel.text      = model.publish_time
//        mNewsPageViewsLabel.text = "浏览数:" + model.browse_count
//        if model.news_description.isNotEmpty {
//            mNewsDescriptionLabel.text = model.news_description
//        }
//        
//        if model.cover.isNotEmpty {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                sleep(1)
//                self.mNewsCoverImageView.hnk_setImageFromURL(NSURL(string: model.cover)!,placeholder: UIImage(named: "default_news"),format: nil,failure: {(error) in
//                    prints("\(error)")
//                    },success: { (image) in
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.mNewsCoverImageView.image = image
//                        })
//                })
//            })
//        }
//    }
//    
//    override func setHighlighted(highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//        if highlighted {
//            mBackgroundImageView.image = UIImage(named: "course_cell_bg_click")
//        } else {
//            mBackgroundImageView.image = UIImage(named: "course_cell_bg")
//        }
//    }
//    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//}
