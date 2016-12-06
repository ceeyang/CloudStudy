//
//  HomeCourseCell.swift
//  CloudStudy
//
//  Created by pro on 2016/12/5.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeCourseCell: UITableViewCell {

    private var layoutStyle : HomeIconLayoutStyle?
    private var itemsArr    : Array<DocFileModel>  = []
    private var scrollView  = UIScrollView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator   = false
        scrollview.isPagingEnabled                = true
        scrollview.bounces                        = false
        scrollview.backgroundColor                = UIColor.clear
        scrollview.delegate                       = self
        contentView.addSubview(scrollview)
        self.scrollView                           = scrollview
    }
    
    public func setupScrollView(with style:HomeTableViewLayoutStyle, items:Array<JSON>) {
        
        itemsArr.removeAll()
        for dic in items {
            let course = DocFileModel()
            course.parseData(json: dic, arrayValues: nil, descriptionName: "Description")
            itemsArr.append(course)
        }
        
        let coverHeight = kHomeStandardImageSize.height
        let itemSpace   = kHeightForHomeItemSpace
        let labelHeight = kHeightForHomeTitleLabl
        let starGrade   = kHeightForStarRating
        
        switch style {
        case .PageDisableItemsForSingleCell: //每个cell有若干个items，可滚动，不分页
            
            let coverWidth      = kHomeAutoImageWidth
            let autoCoverHeight = coverWidth * 128 / 192
            scrollView.frame    = CGRect(x:10, y:0, w:kScreenWidth - 10, h:autoCoverHeight + 2 * itemSpace + 2 * labelHeight + starGrade + 8)
            layoutPageDisableItemsForSingleCell(with: itemsArr)
            break
            
        case .PageEnableItemsForSingleCell: //每个cell有若干个items，可滚动，分页，每页显示2个items
            
            scrollView.frame    = CGRect(x:0, y:0, w:kScreenWidth, h:coverHeight + 2 * itemSpace + 2 * labelHeight + starGrade + 8)
            layoutPageEnableItemsForSingleCell(with: itemsArr)
            break
            
        case .FourItemsForEachCell: //每个cell有4个items，可滚动，分页，每页显示4个items
            
            var frame : CGRect  = CGRect.zero
            if itemsArr.count < 3 { /** 显示一行 */
                frame           = CGRect(x:0, y:0, w:kScreenWidth, h:(coverHeight + 2 * itemSpace + 2 * labelHeight + starGrade + 8))
            } else { /** 显示两行 */
                frame           = CGRect(x:0, y:0, w:kScreenWidth, h:2 * (coverHeight + 2 * labelHeight + starGrade) + itemSpace + 8)
            }
            scrollView.frame    = frame
            layoutFourItemsForEachCell(with: itemsArr)
            break
            
        case .ThreeItemsForSingleCell: //每个cell有3行，每行显示1个item，可滚动，分页，每页显示3行
            
            let coverWidth      = kHeightForMinImageWidth
            let count           = CGFloat(items.count > 3 ? 3 : items.count)
            scrollView.frame    = CGRect(x: 0, y: 0, w: kScreenWidth, h: count * (coverWidth * 128 / 192) + 2 * 24 + 8)
            layoutThreeItemsForSingleCell(with: itemsArr)
            break
            
        default:
            break
        }
    }
    
    //每个cell有若干个items，可滚动，不分页
    private func layoutPageDisableItemsForSingleCell(with items:Array<DocFileModel>) {
//        scrollView.removeSubviews()
//        let coverWidth = kHomeAutoImageWidth
//        let spaceX     = 0
//        let idx        = 0
//        
//        for course in items {
//            
//        }
        
//        for(HomeCourseModel * obj in items) {
//            HomeCourseView * courseView = [[HomeCourseView alloc] initWithFrame:CGRectMake(idx * coverWidth + spaceX, 0, coverWidth, self.scrollView.frame.size.height)];
//            
//            courseView.tag = idx;
//            [courseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//                [self courseItemDidSelectedAtIndex:idx items:items];
//                }]];
//            [courseView configCourseWithData:obj];
//            spaceX += 10;
//            
//            [self.scrollView addSubview:courseView];
//            idx++;
//        }
//        
//        self.scrollView.contentSize = CGSizeMake(items.count * coverWidth + (items.count - 1) * 10 , self.scrollView.frame.size.height);
//        self.scrollView.pagingEnabled = NO;
    }
    
    //每个cell有若干个items，可滚动，分页，每页显示2个items
    private func layoutPageEnableItemsForSingleCell(with items:Array<DocFileModel>) {
        
    }
    
    //每个cell有4个items，可滚动，分页，每页显示4个items
    private func layoutFourItemsForEachCell(with items:Array<DocFileModel>) {
        
    }
    
    //每个cell有3行，每行显示1个item，可滚动，分页，每页显示3行
    private func layoutThreeItemsForSingleCell(with items:Array<DocFileModel>) {
        
    }
    
}

extension HomeCourseCell : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
}
