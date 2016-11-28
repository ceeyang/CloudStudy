//
//  DocMainViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/11/5.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import HMSegmentedControl

class DocMainViewController: UIViewController {

    var segmentControl = HMSegmentedControl()
    var currentView    = UIView()
    var docDirectoryVC = UIView()
    var directoryArray : Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "doc"
        view.backgroundColor = kAppBaseColor
        
        addChildVC()
        setupTopTabbar()
    }

    func addChildVC() {
        let directoryVC = DocDirectoryViewController()
        let docNewVC    = DocNewViewController()
        let docHotVC    = DOCHotViewController()
        
        addChildViewController(directoryVC)
        addChildViewController(docNewVC)
        addChildViewController(docHotVC)
    }
    
    func setupTopTabbar() {
        let titles = ["Category", "New", "Hot"]
        segmentControl = HMSegmentedControl(sectionTitles: titles)
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.selectionIndicatorLocation = .down
        segmentControl.selectionStyle = .fullWidthStripe
        segmentControl.segmentWidthStyle = .fixed
        segmentControl.selectionIndicatorColor = kNavigationBarColor
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
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
    
    deinit {
        print("Deinit Success")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

