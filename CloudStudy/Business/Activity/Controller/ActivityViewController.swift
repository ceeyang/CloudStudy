//
//  ActivityViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import HMSegmentedControl

class ActivityViewController: UIViewController {

    fileprivate var segmentControl = HMSegmentedControl()
    fileprivate var currentView    = UIView()
    fileprivate var navigationBar  = CourseSearchBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    fileprivate func setupUI() {
        /** Search Bar */
        let searchBar = CourseSearchBarView()
        searchBar.setSearchBarTitle("Activity")
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(64)
        }
        navigationBar = searchBar
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
