//
//  MainNavigationController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarStyle()
    }

    func setNavigationBarStyle() {
        let image     = UIImage(named: "common_actionbar_bg@3x")
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        self.delegate = self
    }
    
    func backAction() {
        popViewController(animated: true)
    }
    
    func searchAction() {
        presentVC(SearchViewController())
    }
    
    func BarButtonItemWithTarget(_ target:Any?,action:Selector,image:String,selectedImg:String) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setBackgroundImage(UIImage(named:image), for: .normal)
        btn.setBackgroundImage(UIImage(named:selectedImg), for: .highlighted)
        return UIBarButtonItem(customView: btn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MainNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem  = BarButtonItemWithTarget(self, action: #selector(backAction), image: "public_nav_btn_return_n", selectedImg: "public_nav_btn_return_n")
            viewController.navigationItem.rightBarButtonItem = BarButtonItemWithTarget(self, action: #selector(searchAction), image: "course_nav_btn_search_click", selectedImg: "course_nav_btn_search_n")
        }
        super.pushViewController(viewController, animated: animated)
    }
}
