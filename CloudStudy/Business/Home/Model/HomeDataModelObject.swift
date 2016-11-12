//
//  HomeDataModelObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.section]
        if model.content_code == "navigation_module"{
            let layout = HomeLayoutObject(homeIconStyle: HomeIconLayoutStyle(rawValue: model.display_mode_code!)!)
            return layout.cellHeight!
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataArr[indexPath.section]
        
        if model.content_code == "navigation_module" {
            var cell = tableView.dequeueReusableCell(withIdentifier: kHomeIconCellReuseIdentifier, for: indexPath) as? HomeIconCell
            if cell == nil {
                cell = HomeIconCell(style: .default, reuseIdentifier: kHomeIconCellReuseIdentifier)
            }
            cell?.layoutIconWith(style: HomeIconLayoutStyle(rawValue: model.display_mode_code!)!, items: model.nav_list as! Array<IconModel>)
            cell?.iconDidSelectedAction = { [weak self] (model) in
                self?.homeIconDidSelectedWith(model)
            }
            return cell!
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if updateSearchBarStatus != nil {
            updateSearchBarStatus!(scrollView.offsetY)
        }
    }
    
    private func homeIconDidSelectedWith(_ model:IconModel) {
        
        if model.code == "news" {//新闻
            pushTabbarViewControllerWith(NewsMainViewController())
        } else if model.code == "course" {//课程
            pushTabbarViewControllerWith(CourseViewController())
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
    
    private func pushTabbarViewControllerWith(_ viewController:UIViewController) {
        //viewController.hidesBottomBarWhenPushed = true
        if pushToControllerAction != nil {
           pushToControllerAction!(viewController)
        }
    }
}
