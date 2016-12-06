//
//  HomeSubjectCell.swift
//  CloudStudy
//
//  Created by pro on 2016/12/6.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ItemClickActionClourse = (_ model:HomeSubjectModel) -> Void

class HomeSubjectCell: UITableViewCell {

    public var itemClickActionClourse : ItemClickActionClourse?
    
    private var layoutStyle : HomeIconLayoutStyle?
    private var itemsArr    : Array<HomeSubjectModel>  = []
    private var scrollView  = UIScrollView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    public func setupScrollView(with style:HomeTableViewLayoutStyle, items:Array<JSON>) {
        
        itemsArr.removeAll()
        for dic in items {
            let course = HomeSubjectModel()
            course.parseData(json: dic, arrayValues: nil, descriptionName: "Description")
            itemsArr.append(course)
        }
        
        let coverHeight = kHomeStandardImageSize.height
        let itemSpace   = kHeightForHomeItemSpace
        let labelHeight = kHeightForHomeTitleLabl
        
        switch style {
        case .PageDisableItemsForSingleCell:
            
            //每个cell有若干个items，可滚动，不分页
            let coverWidth      = kHomeAutoImageWidth
            let autoCoverHeight = coverWidth * 128 / 192
            scrollView.frame    = CGRect(x:10, y:0, w:kScreenWidth - 10, h:autoCoverHeight + 2 * itemSpace + 2 * labelHeight)
            layoutPageDisableItemsForSingleCell(with: itemsArr)
            break
            
        case .PageEnableItemsForSingleCell:
            
            //每个cell有若干个items，可滚动，分页，每页显示2个items
            scrollView.frame    = CGRect(x:0, y:0, w:kScreenWidth, h:coverHeight + 2 * itemSpace + 2 * labelHeight)
            layoutPageEnableItemsForSingleCell(with: itemsArr)
            break
            
        case .FourItemsForEachCell:
            
            //每个cell有4个items，可滚动，分页，每页显示4个items
            var frame : CGRect  = CGRect.zero
            if itemsArr.count < 3 { /** 显示一行 */
                frame           = CGRect(x:0, y:0, w:kScreenWidth, h:(coverHeight + 2 * itemSpace + 2 * labelHeight))
            } else { /** 显示两行 */
                frame           = CGRect(x:0, y:0, w:kScreenWidth, h:2 * (coverHeight + 2 * labelHeight) + 12)
            }
            scrollView.frame    = frame
            layoutFourItemsForEachCell(with: itemsArr)
            break
            
        case .ThreeItemsForSingleCell:
            
            //每个cell有3行，每行显示1个item，可滚动，分页，每页显示3行
            let coverWidth      = kHeightForMinImageWidth
            let count           = CGFloat(items.count > 3 ? 3 : items.count)
            scrollView.frame    = CGRect(x: 0, y: 0, w: kScreenWidth, h: count * (coverWidth * 128 / 192) + 2 * 24)
            layoutThreeItemsForSingleCell(with: itemsArr)
            break
            
        default:
            break
        }
    }
    
    //每个cell有若干个items，可滚动，不分页
    private func layoutPageDisableItemsForSingleCell(with items:Array<HomeSubjectModel>) {
        scrollView.removeSubviews()
        let coverWidth = kHomeAutoImageWidth
        var spaceX     = 0
        var idx        = 0
        
        for subject in items {
            let subjectView = HomeSubjectView(frame: CGRect(x:CGFloat(idx) * coverWidth + CGFloat(spaceX), y:0, w:coverWidth, h:scrollView.frame.size.height))
            subjectView.tag = idx;
            let tap = UITapGestureRecognizer()
            tap.addAction(block: { [weak self](tap) in
                self?.courseItemDidSelected(with: subject)
            })
            subjectView.addGestureRecognizer(tap)
            subjectView.configSubject(with: subject)
            spaceX += 10
            idx    += 1
            
            scrollView.addSubview(subjectView)
        }
        scrollView.contentSize = CGSize(width:CGFloat(items.count) * coverWidth + CGFloat((items.count - 1) * 10) , height:scrollView.frame.size.height);
        scrollView.isPagingEnabled = false
    }
    
    //每个cell有若干个items，可滚动，分页，每页显示2个items
    private func layoutPageEnableItemsForSingleCell(with items:Array<HomeSubjectModel>) {
        scrollView.removeSubviews()
        let coverWidth = kHomeStandardImageSize.width
        var spaceX     = 0
        var spacePage  = 0
        var idx        = 0
        
        for subject in items {
            if(idx != 0 && idx % 2 == 0) {
                spacePage += 10
            }
            let subjectView = HomeSubjectView(frame: CGRect(x:10 + CGFloat(idx) * coverWidth + CGFloat(spaceX) + CGFloat(spacePage), y:0, w:coverWidth, h:scrollView.frame.size.height))
            subjectView.tag = idx;
            let tap = UITapGestureRecognizer()
            tap.addAction(block: { [weak self](tap) in
                self?.courseItemDidSelected(with: subject)
            })
            subjectView.addGestureRecognizer(tap)
            subjectView.configSubject(with: subject)
            spaceX += 10
            idx    += 1
            
            scrollView.addSubview(subjectView)
        }
        
        let totalPage = items.count % 2 == 0 ? items.count / 2 : items.count / 2 + 1;
    
        //2.每个item之间的间隔
        let gap = 10
        //3.每一页的宽度
        let widthForPage = 3 * CGFloat(gap) + CGFloat(coverWidth) * 2
        //4.scrollView的contentSize.width
        let contentWidth = CGFloat(totalPage) * CGFloat(widthForPage)
        //5.设置contentSize
        scrollView.contentSize = CGSize(width:contentWidth, height:scrollView.frame.size.height);
        scrollView.isPagingEnabled = true;
    }
    
    //每个cell有4个items，可滚动，分页，每页显示4个items
    private func layoutFourItemsForEachCell(with items:Array<HomeSubjectModel>) {
        scrollView.removeSubviews()
        
        let standardWidthForImage = kHomeStandardImageSize.width
        let heightForItems        = scrollView.frame.size.height / 2 - 6
        let widthForPage          = standardWidthForImage * 2 + 30
        
        var tempIdx               = 0
        var idx                   = 0
        var itemSpaceX            = 0
        var itemSpaceY            = 0
        var widthForItems         = 0
        
        for subject in items {
            if(idx != 0 && idx % 2 == 0) {
                itemSpaceX = 0;
                itemSpaceY += 12;
            }
            if(idx != 0 && idx % 4 == 0) {
                tempIdx                 = 0
                widthForItems          += Int(widthForPage)
                itemSpaceY              = 0
            }
            let subjectView = HomeSubjectView(frame: CGRect(x:10 + CGFloat(idx % 2) *  standardWidthForImage + CGFloat(itemSpaceX) + CGFloat(widthForItems), y:CGFloat(tempIdx / 2) * heightForItems + CGFloat(itemSpaceY), w:standardWidthForImage,h: heightForItems))
            subjectView.tag = idx;
            let tap = UITapGestureRecognizer()
            tap.addAction(block: { [weak self](tap) in
                self?.courseItemDidSelected(with: subject)
            })
            subjectView.addGestureRecognizer(tap)
            subjectView.configSubject(with: subject)
            
            itemSpaceX += 10
            tempIdx    += 1
            idx        += 1
            
            scrollView.addSubview(subjectView)
        }
        //1.算出总页数
        let totalPage = items.count % 4 == 0 ? items.count / 4 : items.count / 4 + 1
        //2.每页的宽度
        let widthForContent = CGFloat(totalPage) * self.scrollView.frame.size.width
        //3.contentsize
        scrollView.contentSize = CGSize(width:widthForContent, height:scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
    }
    
    //每个cell有3行，每行显示1个item，可滚动，分页，每页显示3行
    private func layoutThreeItemsForSingleCell(with items:Array<HomeSubjectModel>) {
        scrollView.removeSubviews()
        
        let minImageWidth = kHeightForMinImageWidth
        let heightForItem = minImageWidth * 128 / 192
        //整条item的宽度 ＝ 封面图宽度 ＋ 封面图与标题之间的间隔宽度 ＋ 标题的宽度
        let widthForItem  = minImageWidth + 12 + (kScreenWidth - minImageWidth - 10 - 12 - 10)
        var spaceY        = 0
        var pageSpace     = 0
        var tempIdx       = 0
        var idx           = 0
        
        for subject in items {
            
            if(idx != 0 && idx % 3 == 0) {
                spaceY     = 0
                tempIdx    = 0
                pageSpace += 20
            }
            let subjectView = HomeSubjectView(frame: CGRect(x:10 + CGFloat(idx / 3) * widthForItem + CGFloat(pageSpace), y:CGFloat(tempIdx) * heightForItem + CGFloat(spaceY), w:widthForItem, h:heightForItem))
            subjectView.tag = idx;
            let tap = UITapGestureRecognizer()
            subjectView.resetRectForSubviews()
            tap.addAction(block: { [weak self](tap) in
                self?.courseItemDidSelected(with: subject)
            })
            scrollView.addSubview(subjectView)
            subjectView.addGestureRecognizer(tap)
            subjectView.configSubject(with: subject)
            
            spaceY        += 12
            tempIdx       += 1
            idx           += 1
        }
        //1.算出总页数
        let totalPage = items.count % 3 == 0 ? items.count / 3 : items.count / 3 + 1;
        //2.每页的宽度
        let widthForContent = CGFloat(totalPage) * scrollView.frame.size.width
        //3.contentsize
        scrollView.contentSize = CGSize(width:widthForContent, height:scrollView.frame.size.height);
        scrollView.isPagingEnabled = true
    }

    private func courseItemDidSelected(with model:HomeSubjectModel) {
        itemClickActionClourse?(model)
    }
}


extension HomeSubjectCell : UIScrollViewDelegate {
    
}
