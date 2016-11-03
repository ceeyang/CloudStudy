//
//  HomeStyleConfig.swift
//  CloudStudy
//
//  Created by pro on 2016/11/2.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import Foundation

let CurrentDevice          = UIDevice.current



let kHomeStandardImageSize = CGSize(width: kScreenWidth - 30 / 2, height: (((kScreenWidth - 30)/2) * 128) / 192 )
let kSizeForRankingView    = CGSize(width:100, height:140)
let kHomeAutoImageWidth     : CGFloat = CurrentDevice.isIphonePlus() ? 159.666 : CurrentDevice.isMediumIphone() ? 140  : 126
let kWidthForBlankPage      : CGFloat = CurrentDevice.isIphonePlus() ? 394 : CurrentDevice.isMediumIphone() ? 335 : 280
let kSizeForHomeIcon        : CGFloat = CurrentDevice.isIphonePlus() ? 45 : CurrentDevice.isMediumIphone() ? 40 : 40   //五个时候的icon size
let kSizeForHomeMaxIcon     : CGFloat = CurrentDevice.isIphonePlus() ? 54 : CurrentDevice.isMediumIphone() ? 48 : 40   //四个时候的icon size
let kHeightForMinImageWidth : CGFloat = CurrentDevice.isIphonePlus() ? 140 : CurrentDevice.isMediumIphone() ? 130 : 120
let kWidthForMinRankingView       : CGFloat = kScreenWidth / 2.65
let kHeightForBlankPageCell       : CGFloat = 100
let kHeightForHomeTitleLabl       : CGFloat = 20
let kHeightForHomeIconTitleLabl   : CGFloat = 8
let kHeightForHomeItemSpace       : CGFloat = 12
let kHeightForSectionTitle        : CGFloat  = 44
let kHeightForSpaceOfIconAndTitle : CGFloat = 6
let kHeightForHomePageControl     : CGFloat = 10
let kRatioOfRankingCoverImage     : CGFloat = 0.7137
let kHeightForStarRating          : CGFloat = 14


//MARK: - Enum -
enum HomeTableViewModule : Int {
    case Icon                //菜单模块
    case Course              //课程模块
    case Subject             //专题模块
    case Knowlege            //知识模块
    case Activity            //活动模块
    case LearningPath        //必修模块
    case RankingList         //讲师榜
    case RecommandActivity   //推荐活动
    case BlankPage           //空白页
}

enum HomeTableViewLayoutStyle : Int {
    
    case PageDisableItemsForSingleCell //一个cell里有若干个items，可以滚动，但不分页
    case PageEnableItemsForSingleCell  //一个cell里有若干个items，可以滚动，分页，每页2个
    case FourItemsForEachCell          //一个cell里有4个items，每行2个item，可左右滑动，分页，每页4个items
    case ThreeItemsForSingleCell       //一个cell里有3个items，每行1个item，可左右滑动，分页，每页3个items
    case BlankPage                     //空白页
}

enum HomeIconLayoutStyle : Int {
    case FourPerRowForScrollingEnable   // 单行 x 4item ,可滚动
    case FivePerRowForScrollingEnbale   // 单行 x 5item ,可滚动
    case EightPerPageForScrollingEnable // 双行，每行4个，每页八个，可滚动
    case TenPerPageForScrollingEnbale   // 双行，每行5个，每页10个，可滚动
    case HomeIconAreaBlankPage          // 无数据，空白页
}

