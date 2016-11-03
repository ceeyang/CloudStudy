//
//  HomeLayoutObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/2.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeLayoutObject: NSObject {
    
    private var HeightForStandardImage : CGFloat? //标准封面图的高度
    private var HeightForAutoImage     : CGFloat? //中等大小封面图的高度
    private var heightForMinImage      : CGFloat? //小封面图的高度
    private var HeightForLabel         : CGFloat? //标准label的高度
    private var heightForRatingStar    : CGFloat? //评分控件高度
    private var HeightForItemSpace     : CGFloat? //item之间的间距高度
    private var heightForBottomPadding : CGFloat? //底边距
    
    public  var cellHeight             : CGFloat?
    
    override init() {
        
    }
    
    convenience init(module:HomeTableViewModule,layoutStyle:HomeTableViewLayoutStyle,dataArr:Array<AnyObject>) {
        self.init()
        HeightForStandardImage = kHomeStandardImageSize.height
        let width = kHomeAutoImageWidth
        HeightForAutoImage     = width * 128 / CGFloat(192)
        HeightForLabel         = kHeightForHomeTitleLabl
        heightForRatingStar    = kHeightForStarRating
        HeightForItemSpace     = kHeightForHomeItemSpace
        let minWidth           = kHeightForMinImageWidth
        heightForMinImage      = minWidth * 128 / 192
        heightForBottomPadding = 15
        startToCalculateCellHeightWith(module: module, layoutStyle: layoutStyle, dataArr: dataArr)
    }
    
    private func startToCalculateCellHeightWith(module:HomeTableViewModule,layoutStyle:HomeTableViewLayoutStyle,dataArr:Array<AnyObject>) {
        switch module {
        case .Course:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .Subject:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .Knowlege:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .Activity:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .LearningPath:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .RankingList:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        case .RecommandActivity:
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                break
            case .PageEnableItemsForSingleCell:
                break
            case .FourItemsForEachCell:
                break
            case .ThreeItemsForSingleCell:
                break
            case .BlankPage:
                break
            }
            break
        default:
            break
        }
    }
    
    private func calculateCourseStyleOne() {
        
    }
    
    private func calculateCourseStyleTwo() {
        //
    }
    private func calculateCourseStyleFour(model:RegionModel) {
        //
    }

    convenience init(homeIconStyle layoutStyle:HomeIconLayoutStyle) {
        self.init()
        startCalculateMenuIconsHeightWithStyle(layoutStyle: layoutStyle)
    }
    
    private func startCalculateMenuIconsHeightWithStyle(layoutStyle:HomeIconLayoutStyle) {
        switch layoutStyle {
        case .FourPerRowForScrollingEnable:
            calculateIconStyleOne()
            break
        case .FivePerRowForScrollingEnbale:
            calculateIconStyleTwo()
            break
        case .EightPerPageForScrollingEnable:
            calculateIconStyleThree()
            break
        case .TenPerPageForScrollingEnbale:
            calculateIconStyleFour()
            break
        case .HomeIconAreaBlankPage:
            calculateBlankPageHeight()
            break
        }
    }
    /** 一行四个菜单的高度 */
    private func calculateIconStyleOne() {
        let sizeForItem          = kSizeForHomeMaxIcon
        let heightForLabel       = kHeightForHomeIconTitleLabl
        let heightForSpace       = kHeightForSpaceOfIconAndTitle
        let heightForPageControl = kHeightForHomePageControl
        
        cellHeight               = sizeForItem + 2 * heightForSpace + heightForLabel + 19 * 2 + heightForPageControl - 2.5
    }
    /** 一行五个菜单的高度 */
    private func calculateIconStyleTwo() {
        let sizeForItem          = kSizeForHomeIcon
        let heightForLabel       = kHeightForHomeIconTitleLabl
        let heightForSpace       = kHeightForSpaceOfIconAndTitle
        let heightForPageControl = kHeightForHomePageControl
        
        cellHeight               = sizeForItem + 2 * heightForSpace + heightForLabel + 19 * 2 + heightForPageControl - 2.5
    }
    /** 两行四个菜单的高度 */
    private func calculateIconStyleThree() {
        let sizeForItem          = kSizeForHomeMaxIcon
        let heightForLabel       = kHeightForHomeIconTitleLabl
        let heightForSpace       = kHeightForSpaceOfIconAndTitle
        let heightForPageControl = kHeightForHomePageControl
        
        cellHeight               = 2 * (sizeForItem + heightForSpace + heightForLabel) + 19 * 4 + heightForPageControl - 2.5
    }
    /** 两行五个菜单的高度 */
    private func calculateIconStyleFour() {
        let sizeForItem          = kSizeForHomeIcon
        let heightForLabel       = kHeightForHomeIconTitleLabl
        let heightForSpace       = kHeightForSpaceOfIconAndTitle
        let heightForPageControl = kHeightForHomePageControl
        
        cellHeight               = 2 * (sizeForItem + heightForSpace + heightForLabel) + 19 * 4 + heightForPageControl - 2.5
    }
    /** 空白页高度 */
    private func calculateBlankPageHeight() {
        let heightForBlankPage   = kHeightForBlankPageCell
        cellHeight               = heightForBlankPage;
    }
}
