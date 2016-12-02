//
//  DocDetailViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/12/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class DocDetailViewController: UIViewController {

    public var detailModel    : DocDetailModel?
    
    var playButton  : UIButton!
    
    var detailMainView = DocDetailMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailMainView = DocDetailMainView(frame:view.frame,detailModel:detailModel!)
        view.addSubview(detailMainView)
        
    }
    
    func play() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
