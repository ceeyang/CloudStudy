//
//  MainTabBarController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public func createChildVC() {
        let homePage = HomeViewController()
        addChildVC(childVC: homePage, title: "Home", image: "new_tab_home_n", selectedImage: "new_tab_home")
        
        let coursePage = CourseMainViewController()
        addChildVC(childVC: coursePage, title: "Course", image: "new_tab_course_n", selectedImage: "new_tab_course")
        
        let activityPage = ActivityViewController()
        addChildVC(childVC: activityPage, title: "Activity", image: "new_tab_active_n", selectedImage: "new_tab_active")
        
        let askPage = AskViewController()
        addChildVC(childVC: askPage, title: "Ask", image: "new_tab_ask_home_n", selectedImage: "new_tab_ask_home")
        
        let personalPage = PersonalViewController()
        addChildVC(childVC: personalPage, title: "Personal", image: "new_tab_my_n", selectedImage: "new_tab_my")
        
    }
    
    public func addChildVC(childVC: UIViewController,title:String,image:String,selectedImage:String) {
        childVC.title   = title;
        let normalImg   = UIImage(named: image)
        let selectedImg = UIImage(named: selectedImage)
        childVC.tabBarItem.image = normalImg?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImg?.withRenderingMode(.alwaysOriginal)
        let textAttrs = [NSForegroundColorAttributeName : RGB(r: 51, g: 51, b: 51)]
        let selectedTextAttrs = [NSForegroundColorAttributeName : RGB(r: 85, g: 85, b: 85)]
        childVC.tabBarItem.setTitleTextAttributes(textAttrs, for: .normal)
        childVC.tabBarItem.setTitleTextAttributes(selectedTextAttrs, for: .selected)
        let nav = MainNavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
