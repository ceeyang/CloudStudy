//
//  HomeViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIScrollViewDelegate {
    
    var navigationBar : HomeSearchBar!
    var imagePlayer   : ImagePlayer!
    var scrollview    : UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        
        /** main scrollview */
        scrollview = UIScrollView(frame:UIEdgeInsetsInsetRect(view.frame, UIEdgeInsetsMake(-20, 0, 0, 0)))
        scrollview.showsVerticalScrollIndicator = true
        scrollview.isScrollEnabled = true
        scrollview.delegate = self
        scrollview.contentSize = CGSize(width: 0, height: kScreenHeight + 200)
        view.addSubview(scrollview)
        
        /** Search Bar */
        let searchBar = HomeSearchBar()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(64)
        }
        navigationBar = searchBar
        
        imagePlayer = ImagePlayer(frame:CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        scrollview.addSubview(imagePlayer)
        imagePlayer.imageArr = ["banner_bg_1","banner_bg_1","banner_bg_1"]
        imagePlayer.reloadData()
        
        addAction()
    }
    
    
    func addAction() {
        navigationBar.searchBtnAction  = { (sender:UIButton) in
            print(sender)
        }
        navigationBar.messageBtnAction = { (sender:UIButton) in
            print(sender)
        }
        navigationBar.qrCodeBtnAction  = { (sender:UIButton) in
            print(sender)
        }
        imagePlayer.imageDidSelectedAction = { (index:Int) in
            print(index)
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollview.contentOffset.y + 20
        if offY  < 0 {
            navigationBar.isHidden = true
        } else if offY <= imagePlayer.frame.size.height {
            navigationBar.isHidden = false
            navigationBar.updateNavigationBarStatus(alpha:offY/imagePlayer.frame.size.height)
        } else {
            navigationBar.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
