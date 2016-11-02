//
//  HomeTopContainer.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeTopContainer: UIView {

    private var imagePlayer   : ImagePlayer!
    private var imageArr:Array<String> = []
    private var bannerArr:Array<BannerModel>  = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        imagePlayer = ImagePlayer(frame:frame)
        addSubview(imagePlayer)
        imagePlayer.defaultImageName = "banner_bg_1"
        imagePlayer.imageDidSelectedAction = { [weak self](index:Int) in
            self?.bannerDidSelectedWith(model: (self?.bannerArr[index])!)
        }
    }
    
    public func reloadBanner(bannerArr:Array<BannerModel>) {
        imageArr.removeAll()
        for model in bannerArr {
            imageArr.append(model.image!)
        }
        imagePlayer.imageArr = imageArr
        imagePlayer.reloadData()
    }

    private func bannerDidSelectedWith(model:BannerModel)  {
        print(model.id,model.image,model.type,model.url)
    }
    
}
