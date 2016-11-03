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
    
    public var reloadBannerClosure : ReloadHomeBannerClosure?
    
    private var layoutFinished : [String:Bool] = [:]  // 根据 content_code 判断该类是否加载完成
    
    public func sendUpdateFileRequest() {
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
    
    public func sendHomeLayoutRequest() {
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
            let module = dic["content_code"].stringValue
            layoutFinished[module] = false
            /** 首页 ICON 特殊处理 */
            if module == "navigation_module"  {
                let region = RegionModel()
                region.parseData(json: dic, arrayValues: ["nav_list"])
                regionArr.append(region)
                DispatchQueue.global().async { [weak self] in
                    self?.startLoadingIconData(model:region)
                }
            } else {
                let region = RegionModel()
                region.parseData(json: dic)
                regionArr.append(region)
                DispatchQueue.global().async {[weak self] in
                    self?.startLoadingModelDetail(model:region)
                }
            }
        }
    }
    
    private func startLoadingIconData(model:RegionModel) {
        let iconJsonArr  = model.nav_list
        var iconModelArr:Array<IconModel> = []
        for icon in iconJsonArr! {
            let iconModel = IconModel()
            iconModel.parseData(json:icon as! JSON)
            iconModelArr.append(iconModel)
        }
    }
    
    private func startLoadingModelDetail(model:RegionModel) {
    }
    
}
