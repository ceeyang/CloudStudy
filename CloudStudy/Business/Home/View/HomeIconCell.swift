//
//  HomeIconCell.swift
//  CloudStudy
//
//  Created by pro on 2016/11/4.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

typealias HomeIconDidSelectedActionClourse = (_ model:IconModel) -> Void

class HomeIconCell: UITableViewCell,UIScrollViewDelegate {

    
    private var layoutStyle : HomeIconLayoutStyle?
    private var items       : Array<IconModel>  = []
    private var scrollView  = UIScrollView()
    private var pageControl = UIPageControl()
    
    public var iconDidSelectedAction:HomeIconDidSelectedActionClourse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator   = false
        scrollview.isPagingEnabled                = true
        scrollview.bounces                        = false
        scrollview.backgroundColor                = UIColor.clear
        scrollview.delegate                       = self
        contentView.addSubview(scrollview)
        self.scrollView                           = scrollview
        
        let pageControl                           = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = RGBA(r: 0, g: 0, b: 0,a:0.3)
        pageControl.pageIndicatorTintColor        = RGBA(r: 0, g: 0, b: 0, a: 0.05)
        contentView.addSubview(pageControl)
        self.pageControl                          = pageControl
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutIconWith(style:HomeIconLayoutStyle,items:Array<IconModel>) {
        var iconSize          = kSizeForHomeIcon
        let heightForLabel    = kHeightForHomeIconTitleLabl
        let heightForSpace    = kHeightForSpaceOfIconAndTitle;
        var heightForIconItem = iconSize + heightForSpace + heightForLabel
        
        scrollView.isHidden = false
        switch style {
        case .FourPerRowForScrollingEnable:   // 单行 x 4item ,可滚动
            
            iconSize          = kSizeForHomeMaxIcon
            heightForIconItem = iconSize + heightForSpace + heightForLabel
            scrollView.frame  = CGRect(x: 0, y: 19, w: kScreenWidth, h: heightForIconItem + 10)
            layoutIconStyleOne(items:items)
            
            break
        case .FivePerRowForScrollingEnbale:    // 单行 x 5item ,可滚动
            
            scrollView.frame  = CGRect(x: 0, y: 19, w: kScreenWidth, h: heightForIconItem + 10)
            layoutIconStyleTwo(items: items)
            
            break
        case .EightPerPageForScrollingEnable:  // 双行，每行4个，每页八个，可滚动
            
            iconSize = kSizeForHomeMaxIcon;
            heightForIconItem = iconSize + heightForSpace + heightForLabel;
            scrollView.frame  = CGRect(x: 0, y: 19, w: kScreenWidth, h: heightForIconItem * 2 + 38)
            layoutIconStyleThree(items: items)
            
            break
        case .TenPerPageForScrollingEnbale:    // 双行，每行5个，每页10个，可滚动

            scrollView.frame = CGRect(x: 0, y: 19, w: kScreenWidth, h: heightForIconItem * CGFloat(2) + 38)
            layoutIconStyleFour(items:items)
            
            break
        default:                               // 无数据，空白页
            break
        }
        
        let maxY    = scrollView.frame.maxY
        let centerX = scrollView.centerX
        pageControl.frame = CGRect(origin: CGPoint(x:centerX-30, y:maxY), size: CGSize(width: 60, height: kHeightForHomePageControl))
    }
    
    private func layoutIconStyleOne(items: Array<IconModel>){
        scrollView.removeSubviews()
        let widthForItem = kScreenWidth / 4
        var index = 0
        for model in items {
            let homeIcon  = HomeIconView(frame: CGRect(x:CGFloat(index) * widthForItem,y:0,w:widthForItem,h:scrollView.height), layoutStyle: .FourPerRowForScrollingEnable)
            homeIcon.tag  = index
            homeIcon.addTapGesture(action: { [weak self](tap) in
                if self?.iconDidSelectedAction != nil {
                    self?.iconDidSelectedAction!(model)
                }
            })
            homeIcon.setTitle(model.name!, imageName: getImageNameWith(model))
            scrollView.addSubview(homeIcon)
            index += 1
        }
        let totalPage = items.count % 3 == 0 ? items.count / 4 : items.count / 4 + 1
        scrollView.contentSize = CGSize(width: CGFloat(totalPage) * scrollView.width, height: 0)
        pageControl.numberOfPages = totalPage
    }
    
    
    //开始布局样式2
    private func layoutIconStyleTwo(items:Array<IconModel>) {
        scrollView.removeSubviews()
        
        let widthForItem  = kScreenWidth / 5
        var index         = 0
        for model in items {
            
            let homeIcon  = HomeIconView(frame: CGRect(x:CGFloat(index) * widthForItem,y:0,w:widthForItem,h:scrollView.height), layoutStyle: .FivePerRowForScrollingEnbale)
            homeIcon.tag  = index
            homeIcon.addTapGesture(action: { [weak self](tap) in
                if self?.iconDidSelectedAction != nil {
                    self?.iconDidSelectedAction!(model)
                }
                })
            homeIcon.setTitle(model.name!, imageName: getImageNameWith(model))
            scrollView.addSubview(homeIcon)
            index += 1
        }
        
        let totalPage = items.count % 5 == 0 ? items.count / 5 : items.count / 5 + 1
        scrollView.contentSize = CGSize(width: CGFloat(totalPage) * scrollView.width, height: 0)
        pageControl.numberOfPages = totalPage
    }
    
    private func layoutIconStyleThree(items:Array<IconModel>) {
        scrollView.removeSubviews()
        
        let widthForItem   = kScreenWidth / 4
        let widthForPage   = self.scrollView.frame.size.width
        let heightForItem  = self.scrollView.frame.size.height / 2
        
        var heightForSpace : CGFloat = 0
        var tempPageSpace  : CGFloat = 0
        
        var tempIdx        = 0
        var idx            = 0
        
        for model in items {
            if(tempIdx != 0 && tempIdx % 8 == 0) {
                tempIdx = 0
                tempPageSpace += widthForPage
                heightForSpace = 0;
            }
            if(tempIdx != 0 && tempIdx % 4 == 0) {
                heightForSpace += 9.5;
            }
            
            let homeIcon  = HomeIconView(frame: CGRect(x:CGFloat(idx % 4) * widthForItem + tempPageSpace,
                                                       y:CGFloat(tempIdx / 4) * heightForItem + heightForSpace,
                                                       w:widthForItem,
                                                       h: heightForItem - 9.5),
                                         layoutStyle: .EightPerPageForScrollingEnable)
            homeIcon.setTitle(model.name!, imageName: getImageNameWith(model))
            homeIcon.tag = idx;
            homeIcon.addTapGesture(action: { [weak self](tap) in
                if self?.iconDidSelectedAction != nil {
                    self?.iconDidSelectedAction!(model)
                }
                })
            scrollView.addSubview(homeIcon)
            
            tempIdx += 1
            idx     += 1
        }
        //1.总页数
        let totalPage = items.count % 8 == 0 ? items.count / 8 : items.count / 8 + 1;
        //2.contentSize
        
        scrollView.contentSize = CGSize(width: widthForPage * CGFloat(totalPage), height: 0)
        pageControl.numberOfPages = totalPage
    }
    
    private func layoutIconStyleFour(items:Array<IconModel>) {
        scrollView.removeSubviews()
        
        let widthForItem   :CGFloat = kScreenWidth / 5
        let widthForPage   :CGFloat = scrollView.width
        let heightForItem  :CGFloat = scrollView.height / 2
        var heightForSpace :CGFloat = 0
        var tempPageSpace  :CGFloat = 0
        var tempIndex               = 0
        var index                   = 0
        for model in items {
            if tempIndex != 0 && tempIndex % 10 == 0 {
                tempIndex = 0
                tempPageSpace += widthForPage
                heightForSpace = 0
            }
            if tempIndex != 0 && tempIndex % 5 == 0 {
                heightForSpace += 9.5
            }
            
            let homeIcon  = HomeIconView(frame: CGRect(x:tempPageSpace + CGFloat(index % 5) * widthForItem,
                                                       y:CGFloat(tempIndex / 5) * heightForItem + heightForSpace,
                                                       w:widthForItem,
                                                       h:heightForItem - 9.5),
                                         layoutStyle: .TenPerPageForScrollingEnbale)
            homeIcon.tag  = index
            homeIcon.addTapGesture(action: { [weak self](tap) in
                if self?.iconDidSelectedAction != nil {
                    self?.iconDidSelectedAction!(model)
                }
                })
            homeIcon.setTitle(model.name!, imageName: getImageNameWith(model))
            scrollView.addSubview(homeIcon)
            index     += 1
            tempIndex += 1
        }
        let totalPage = items.count % 10 == 0 ? items.count / 10 : items.count / 10 + 1
        scrollView.contentSize = CGSize(width: CGFloat(totalPage) * scrollView.width, height: 0)
        pageControl.numberOfPages = totalPage
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentPage = offset.x / scrollView.frame.size.width
        self.pageControl.currentPage = Int(currentPage)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getImageNameWith(_ model:IconModel) -> String {
        var imageName = ""
        if model.code == "code" {
            imageName = "new_menu_news"
        } else if model.code == "course" {
            imageName = "new_menu_course"
        } else if model.code == "subject" {
            imageName = "new_menu_special"
        } else if model.code == "train" {
            imageName = "new_menu_train"
        } else if model.code == "live" {
            imageName = "new_menu_live"
        } else if model.code == "knowledge" {
            imageName = "new_menu_knowledge"
        } else if model.code == "exam" {
            imageName = "new_menu_test"
        } else if model.code == "ask_bar" {
            imageName = "new_menu_ask"
        } else if model.code == "mall" {
            imageName = "new_menu_malls"
        } else if model.code == "path" {
            imageName = "new_menu_route"
        } else if model.code == "survey" {
            imageName = "new_menu_research"
        } else {
            imageName = "new_menu_news"
        }
        return imageName
    }

}

class HomeIconView: UIView {
    
    private var backgroundImageView = UIImageView()
    private var iconBtn             = UIImageView()
    private var titleLabel          = UILabel()
    
    convenience init(frame: CGRect,layoutStyle:HomeIconLayoutStyle) {
        self.init(frame:frame)
        
        var iconSize:CGFloat = kSizeForHomeIcon
        isUserInteractionEnabled = true
        if layoutStyle == .FourPerRowForScrollingEnable || layoutStyle == .EightPerPageForScrollingEnable {
            iconSize = kSizeForHomeMaxIcon
        }
        let backGroundImageView = UIImageView(x: (frame.width - iconSize) / 2, y: 0, w: iconSize, h: iconSize, imageName: "new_head_bg_nor")
        backGroundImageView.isUserInteractionEnabled = false
        addSubview(backGroundImageView)
        self.backgroundImageView = backGroundImageView
        
        let iconBtn = UIImageView(frame: backGroundImageView.bounds)
        iconBtn.setCornerRadius(radius: iconSize/2)
        iconBtn.clipsToBounds = true
        iconBtn.isUserInteractionEnabled = false
        backGroundImageView.addSubview(iconBtn)
        self.iconBtn = iconBtn
        
        let titleLabel = UILabel(x: 0, y: iconSize + kHeightForSpaceOfIconAndTitle, w: frame.width, h: frame.height - iconSize - kHeightForSpaceOfIconAndTitle)
        titleLabel.font = PublicTwelveFont
        titleLabel.textColor = RGB(r: 85, g: 85, b: 85)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        addSubview(titleLabel)
        self.titleLabel = titleLabel
        
    }
    
    public func setTitle(_ title:String,imageName:String) {
        iconBtn.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
