//
//  HomeHeaderTitleView.swift
//  CloudStudy
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeHeaderTitleView: UIView {
    
    private var titleLabel : UILabel!
    public  var moreBtn    : UIButton!

    override init(frame:CGRect) {
        super.init(frame:frame)
        
        let titleTop     : CGFloat = (frame.size.height - 20)/2
        let labelWidth   : CGFloat = frame.size.width - 20
        let moreBtnWidth : CGFloat = 80
        let moreBtnTop   : CGFloat = (frame.size.height - 30)/2
        
        let separator = UIView(frame: CGRect(x: 10, y: titleTop, w: 4, h: 20))
        separator.backgroundColor = kNavigationBarColor
        addSubview(separator)
        
        let titleLabl = UILabel(frame: CGRect(x: separator.frame.maxX + 5, y: titleTop, w: labelWidth, h: 20))
        titleLabl.textColor = PublicTitleColor
        titleLabl.font      = PublicTitleFont
        titleLabl.backgroundColor = UIColor.clear
        titleLabl.textAlignment = .left
        addSubview(titleLabl)

        self.titleLabel = titleLabl
        
        let moreButton = UIButton(type: .custom)
        moreButton.frame = CGRect(x: kScreenWidth - moreBtnWidth, y: moreBtnTop, w: moreBtnWidth, h: 30)
        moreButton.setTitle("More", for: .normal)
        moreButton.setTitleColor(PublicContentColor, for: .normal)
        addSubview(moreButton)
        self.moreBtn = moreButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateTitle(_ title:String) {
        self.titleLabel.text = title
    }
    
}
