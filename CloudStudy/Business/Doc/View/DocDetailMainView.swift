//
//  DocDetailMainView.swift
//  CloudStudy
//
//  Created by pro on 2016/12/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class DocDetailMainView: UIView {

    public var detailModel : DocDetailModel?
    
    convenience init(frame:CGRect,detailModel:DocDetailModel) {
        self.init(frame:frame)
        self.detailModel = detailModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
    
}
