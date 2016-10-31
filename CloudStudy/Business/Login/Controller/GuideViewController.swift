//
//  GuideViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SnapKit

class GuideViewController: UIViewController {

    static let shared = GuideViewController()
    
    var mainScrollView : UIScrollView!
    var imageArray     = ["iphone6_1@2x","iphone6_2@2x","iphone6_3@2x","iphone6_4@2x"]
    
    
    func show() {
        //GuideViewController.shared
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(imageArray.count), height: 0)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        mainScrollView = scrollView
        
        for i in 0..<imageArray.count {
            let imageView = UIImageView(image: UIImage(named: imageArray[i]))
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.left.equalTo(scrollView.snp.left).offset(kScreenWidth * CGFloat(i))
                make.top.equalTo(view)
                make.size.equalTo(CGSize(width: kScreenWidth, height: kScreenHeight))
            })

            if i == imageArray.count - 1 {
                let enterBtn = UIButton()
                enterBtn.backgroundColor = RGB(r: 255, g: 255, b: 255)
                enterBtn.layer.cornerRadius = 2
                enterBtn.layer.masksToBounds = true
                enterBtn.setTitle("Enter", for: .normal)
                enterBtn.setTitleColor(RGB(r: 0, g: 174, b: 255), for: .normal)
                enterBtn.addTarget(self, action: #selector(enterBtnAction), for: .touchUpInside)
                imageView.addSubview(enterBtn)
                enterBtn.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(imageView.snp.centerX)
                    make.bottom.equalTo(imageView.snp.bottom).offset(-30)
                    make.size.equalTo(CGSize(width: 125, height: 40))
                })
            }
        }
    }

    
    func enterBtnAction() {
        self.removeFromParentViewController()
        UserDefaults.standard.set(true, forKey: kIsNotFirstLaunch)
        AppDelegate.shared.buildKeyWindow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
