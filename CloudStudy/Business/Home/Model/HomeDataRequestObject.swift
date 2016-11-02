//
//  HomeDataRequestObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON
import EZSwiftExtensions

typealias ReloadHomeBannerClosure = (_ bannerArr :Array<BannerModel>) -> Void

class HomeDataRequestObject: NSObject {
    
    static let shared = HomeDataRequestObject()
    
    var reloadBannerClosure : ReloadHomeBannerClosure?
    
    
    func sendUpdateFileRequest() {
        HUD.show(.label("loading..."))
        RequestManager.shared.requestCommonDataWith(url: KiOSVersionURL, parameters: nil) { response in
            HUD.hide()
    
            switch response.result {
            case .success(let value):
                let json         = JSON(value)
                
                let currentDate = UserDefaults.standard["date"] as! String
                
                if currentDate == json["date"].stringValue {
                    
                } else {
                    UserDefaults.standard["date"] = json["date"].stringValue
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendHomeLayoutRequest() {
        HUD.show(.label("loading..."))
        RequestManager.shared.requestCommonDataWith(url: HomeLayoutURL, parameters: ["sid":UserInfo.shared.sid]) { [weak self](response) in
            HUD.hide()
            switch response.result {
            case .success(let value):
                let json          = JSON(value)
    
                let bannerListArr = json["data"]["banner_list"].arrayValue
                self?.parseBanner(bannerListArr: bannerListArr)
                
                let regionListArr = json["data"]["region_list"].arrayValue
                self?.parseHomeLayoutData(regionListArr: regionListArr)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseBanner(bannerListArr:Array<JSON>) {
        var bannerResultArr:Array<BannerModel> = []
        for dicJson in bannerListArr {
            let banner = BannerModel()
            banner.parseData(json:dicJson)
            bannerResultArr.append(banner)
        }
        if reloadBannerClosure != nil {
            reloadBannerClosure!(bannerResultArr)
        }
    }
    
    private func parseHomeLayoutData(regionListArr:Array<JSON>) {
        var regionArr:Array<RegionModel> = []
        for dic in regionListArr {

            /** 首页 ICON 特殊处理 */
            let navList = dic["nav_list"].arrayValue
            if navList.count != 0  {
                let region = RegionModel()
                region.parseData(json: dic, arrayValues: ["nav_list"])
                regionArr.append(region)
            } else {
                let region = RegionModel()
                region.parseData(json: dic)
                regionArr.append(region)
            }
        }
        DispatchQueue.global().async {
            for region in regionArr {
                if region.nav_list?.count != 0 && region.nav_list != nil {
                    print(region.nav_list)
                } else {
                    print(Thread.current,region.region_type)
                }
            }
        }
    }
    
    private func startLoadingIconData() {
        
    }
    
    private func startLoadingModelDetail(model:NSDictionary) {
        
    }
    
}
