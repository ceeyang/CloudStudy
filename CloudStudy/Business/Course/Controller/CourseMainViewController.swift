//
//  CourseMainViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/12/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import HMSegmentedControl

class CourseMainViewController: UIViewController {

    fileprivate var segmentControl = HMSegmentedControl()
    fileprivate var currentView    = UIView()
    fileprivate var navigationBar  = CourseSearchBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC()
        setupUI()
    }
    
    func addChildVC() {
        /** 目录视图 */
        let directoryVC     = DocDirectoryViewController()
        let courseLatestVC  = CourseLatestViewController()
        let courseHottestVC = CourseHottestViewController()
        
        addChildViewController(directoryVC)
        addChildViewController(courseLatestVC)
        addChildViewController(courseHottestVC)
        
        directoryVC.directoryType = .course
        directoryVC.setDirectoryDidSelected { [weak self](directory) in
            self?.segmentControl.setSelectedSegmentIndex(1, animated: true)
            self?.segmentControlIndexChangeActionWith(1)
            courseLatestVC.updateTableViewData(with: directory)
        }
    }
    fileprivate func setupUI() {
        
        /** Search Bar */
        let searchBar = CourseSearchBarView()
        searchBar.setSearchBarTitle("Course")
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(64)
        }
        navigationBar = searchBar
        
        
        let titles = ["Category", "Latest", "Hottest"]
        segmentControl = HMSegmentedControl(sectionTitles: titles)
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.selectionIndicatorLocation = .down
        segmentControl.selectionStyle = .fullWidthStripe
        segmentControl.segmentWidthStyle = .fixed
        segmentControl.selectionIndicatorColor = kNavigationBarColor
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(searchBar.snp.bottom)
            make.height.equalTo(44)
        }
        segmentControl.indexChangeBlock = {[weak self](index) in
            self?.segmentControlIndexChangeActionWith(index)
        }
        segmentControl.setSelectedSegmentIndex(1, animated: true)
    }
    
    func segmentControlIndexChangeActionWith(_ index:Int) {
        currentView.removeFromSuperview()
        let currentVC = childViewControllers[index]
        view.addSubview((currentVC.view)!)
        currentView = (currentVC.view)!
        currentVC.view.snp.makeConstraints({ (make) in
            make.top.equalTo(segmentControl.snp.bottom).offset(2)
            make.left.right.bottom.equalTo(view)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
