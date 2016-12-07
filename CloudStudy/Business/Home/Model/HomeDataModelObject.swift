//
//  HomeDataModelObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias UpdateNavigationBarStatusClosurce = (_ offSetY:CGFloat) -> Void
typealias PushToControllerActionClourse = (_ viewController:UIViewController) -> Void

class HomeDataModelObject: NSObject,UITableViewDelegate,UITableViewDataSource {

    public var dataArr : Array<RegionModel> = []
    public var tarGet  : Any?
    public var updateSearchBarStatus : UpdateNavigationBarStatusClosurce?
    public var pushToControllerAction : PushToControllerActionClourse?

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let model :RegionModel = dataArr[section]
        let contentCode : HomeLayoutContentCode = HomeLayoutContentCode(rawValue: model.content_code!)!
        if contentCode == .navigation_module {
            return 0.0001
        } else {
            return kHeightForSectionTitle
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataArr.count - 1 {
            return 0.0001
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model :RegionModel = dataArr[section]
        let contentCode : HomeLayoutContentCode = HomeLayoutContentCode(rawValue: model.content_code!)!
        if contentCode == .navigation_module {
            return nil
        }
        let header = UIView(frame: CGRect(x: 0, y: 0, w: kScreenWidth, h: kHeightForSectionTitle))
        header.backgroundColor = UIColor.white
        let sectionTitleView = HomeHeaderTitleView(frame: CGRect(x: 0, y: 0, w: kScreenWidth, h: kHeightForSectionTitle))
        let title : String = model.region_name ?? ""
        sectionTitleView.updateTitle(title)
        header.addSubview(sectionTitleView)
        sectionTitleView.moreBtn.addAction { [weak self](button) in
            self?.moreBtnClickAction(with: model)
        }
        
        return header;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == dataArr.count - 1) {
            return nil
        }
        let footer = UIView(frame: CGRect(x: 0, y: 0, w: kScreenWidth, h: 10))
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model : RegionModel = dataArr[indexPath.section]
        
        let module  = HomeLayoutContentCode(rawValue: model.content_code!)!
        let style   = HomeTableViewLayoutStyle(rawValue:model.display_mode_code!)!
        
        if model.content_code == "navigation_module"{
            let layout = HomeLayoutObject(homeIconStyle: HomeIconLayoutStyle(rawValue: model.display_mode_code!)!)
            return layout.cellHeight!
        } else if model.content_code == "hot_subject" {
            let layout = HomeLayoutObject(module: module, layoutStyle: style, dataArr: model.dataSourceArr)
            return layout.cellHeight!
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model : RegionModel = dataArr[indexPath.section]
        
        let contentCode : HomeLayoutContentCode = HomeLayoutContentCode(rawValue: model.content_code!)!
        
        switch contentCode {
            
        case .navigation_module:
            
            /** 导航栏 icon */
            var cell = tableView.dequeueReusableCell(withIdentifier: kHomeIconCellReuseIdentifier, for: indexPath) as? HomeIconCell
            if cell == nil {
                cell = HomeIconCell(style: .default, reuseIdentifier: kHomeIconCellReuseIdentifier)
            }
            cell?.layoutIconWith(style: HomeIconLayoutStyle(rawValue: model.display_mode_code!)!, items: model.nav_list as! Array<IconModel>)
            cell?.iconDidSelectedAction = { [weak self] (model) in
                self?.homeIconDidSelectedWith(model)
            }
            cell?.selectionStyle = .none
            return cell!
            
        case .recommended_courses:
            
            /** 推荐课程 */
//            var cell = tableView.dequeueReusableCell(withIdentifier: kHomeCourseCellReuseIdentifier, for: indexPath) as? HomeCourseCell
//            if cell == nil {
//                cell = HomeCourseCell(style: .default, reuseIdentifier: kHomeCourseCellReuseIdentifier)
//            }
//            
            
            break
        case .hot_subject:
            
            /** 推荐讲师 */
            var cell = tableView.dequeueReusableCell(withIdentifier: kHomeSubjectCellReuseIdentifier, for: indexPath) as? HomeSubjectCell
            if cell == nil {
                cell = HomeSubjectCell(style: .default, reuseIdentifier: kHomeSubjectCellReuseIdentifier)
            }
            cell?.setupScrollView(with: HomeTableViewLayoutStyle(rawValue: model.display_mode_code!)!, items: model.dataSourceArr as! Array<JSON>)
            cell?.itemClickActionClourse = { [weak self](subject) in
                self?.homeSubjectDidSelected(with:subject)
            }
            cell?.selectionStyle = .none
            return cell!
        case .hot_knowledge:
            
            break
        case .hot_activity:
            
            break
        case .my_required:
            
            break
        case .lecturers_list:
            
            break
        case .recommended_activity:
            
            break
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateSearchBarStatus?(scrollView.offsetY)
    }
    
    
    //MARK: - ↓↓↓ Actions ↓↓↓ -
    /** More Button Action */
    private func moreBtnClickAction(with model:RegionModel) {
        
    }
    
    //MARK: - Home Icon Action
    private func homeIconDidSelectedWith(_ model:IconModel) {
        
        if model.code == "news" {//新闻
            pushTabbarViewControllerWith(NewsMainViewController())
        } else if model.code == "course" {//课程
            pushTabbarViewControllerWith(CourseMainViewController())
        } else if model.code == "subject" {//专题
            pushTabbarViewControllerWith(SubjectMainViewController())
        } else if model.code == "train" {//培训
            pushTabbarViewControllerWith(TrainMainViewController())
        } else if model.code == "exam" {//考试
            pushTabbarViewControllerWith(ExamMainViewController())
        } else if model.code == "knowledge" {//知识库
            pushTabbarViewControllerWith(DocMainViewController())
        } else if model.code == "ask_bar" {//问吧
            pushTabbarViewControllerWith(DocMainViewController())
        } else if model.code == "path" {//学习路径
            pushTabbarViewControllerWith(PathMainViewController())
        } else if model.code == "live" {//直播
            pushTabbarViewControllerWith(LiveMainViewController())
        } else if model.code == "mall" {//积分商城
            pushTabbarViewControllerWith(StoreMainViewController())
        } else if model.code == "survey" {//调研
            pushTabbarViewControllerWith(ResearchMainViewController())
        }
    }
    
    //MARK: - Subject
    private func homeSubjectDidSelected(with model:HomeSubjectModel) {
        
    }
    
    
    private func pushTabbarViewControllerWith(_ viewController:UIViewController) {
        pushToControllerAction?(viewController)
    }
}
