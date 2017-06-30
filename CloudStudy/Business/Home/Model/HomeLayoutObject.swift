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
    
    
    convenience init(module:HomeLayoutContentCode,layoutStyle:HomeTableViewLayoutStyle,dataArr:Array<Any>) {
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
    
    private func startToCalculateCellHeightWith(module:HomeLayoutContentCode,layoutStyle:HomeTableViewLayoutStyle,dataArr:Array<Any>) {
        switch module {
        case .recommended_courses: /** 推荐课程 */
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                
                calculateCourseStyleOne()
                break
                
            case .PageEnableItemsForSingleCell:
                
                calculateCourseStyleTwo()
                break
                
            case .FourItemsForEachCell:
               
                calculateCourseStyleThree()
                break
                
            case .ThreeItemsForSingleCell:
                
                calculateCourseStyleFour(with: dataArr)
                break
                
            case .BlankPage:
                cellHeight = 60
                break
            }
            break
        case .hot_subject: /** 推荐专题 */
            switch layoutStyle {
            case .PageDisableItemsForSingleCell:
                
                calculateSubjectPageDisableItemsForSingleLayout()
                break
                
            case .PageEnableItemsForSingleCell:
                
                calculateSubjectPageEnableItemsForSingleLayout()
                break
                
            case .FourItemsForEachCell:
                
                calculateSubjectFourItemsForEachLayout()
                break
                
            case .ThreeItemsForSingleCell:
                
                calculateSubjectThreeItemsForSingleLayout(with:dataArr)
                break
                
            case .BlankPage:
                cellHeight = 60
                break
            }
            break
        case .hot_knowledge: /** 热门知识 */
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
                cellHeight = 60
                break
            }
            break
        case .hot_activity: /** 最新活动 */
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
                cellHeight = 60
                break
            }
            break
        case .my_required: /** 我的必修 */
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
                cellHeight = 60
                break
            }
            break
        case .lecturers_list: /** 讲师榜 */
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
                cellHeight = 60
                break
            }
            break
        case .recommended_activity: /** 推荐活动 */
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
                cellHeight = 60
                break
            }
            break
        default:
            break
        }
    }
    
    //========================================================
    // MARK: - Home Couse Style -
    //========================================================

    private func calculateCourseStyleOne() {
        cellHeight = HeightForAutoImage! + 2 * HeightForLabel! + heightForRatingStar! + 20
    }
    
    private func calculateCourseStyleTwo() {
        cellHeight = HeightForStandardImage! + 2 * HeightForLabel! + heightForRatingStar! + 20
    }
    
    private func calculateCourseStyleThree() {
        cellHeight = 2 * (HeightForStandardImage! + 2 * HeightForLabel! + heightForRatingStar!) + 32
    }
    
    private func calculateCourseStyleFour(with dataArr:Array<Any>) {
        let count = CGFloat(dataArr.count > 3 ? 3 : dataArr.count)
        cellHeight = count * heightForMinImage! + count * 12 + 8;
    }
    
    
    //========================================================
    // MARK: - Home Subject Style -
    //========================================================
    private func calculateSubjectPageDisableItemsForSingleLayout() {
        cellHeight = HeightForAutoImage! + 2 * HeightForLabel! + 12
    }
    
    private func calculateSubjectPageEnableItemsForSingleLayout() {
        cellHeight = HeightForStandardImage! + 2 * HeightForLabel! + 12
    }
    private func calculateSubjectFourItemsForEachLayout() {
        cellHeight = 2 * (HeightForStandardImage! + 2 * HeightForLabel!) + 24
    }
    
    private func calculateSubjectThreeItemsForSingleLayout(with dataArr:Array<Any>) {
        let count = CGFloat(dataArr.count > 3 ? 3 : dataArr.count)
        cellHeight = count * heightForMinImage! + count * 12
    }
    
    
    //========================================================
    // MARK: - Home Icon Style -
    //========================================================
    convenience init(homeIconStyle layoutStyle:HomeIconLayoutStyle) {
        self.init()
        startCalculateMenuIconsHeightWithStyle(layoutStyle: layoutStyle)
    }
    
    /** Private Method */
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
