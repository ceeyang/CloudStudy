//
//  CourseDetailViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/12/2.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON
import MobilePlayer

class CourseDetailViewController: UIViewController {

    public var detailModel : CourseDetailModel!
    
    var playerVC : MobilePlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4")
        playerVC = MobilePlayerViewController(contentURL: url!)
        addChildViewController(playerVC)
        
        view.addSubview(playerVC.view)
        playerVC.view.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(200)
        }
        
        playerVC.play()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
