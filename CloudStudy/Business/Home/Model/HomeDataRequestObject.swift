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

class HomeDataRequestObject: NSObject {
    
    static let shared = HomeDataRequestObject()
    
    public var reloadBannerClosure : ReloadHomeBannerClosure?
    public var reloadHomeDataClosure : ReloadHomeDataClosure?
    
    
    private var regionDataArr   : Array<RegionModel> = []
    private var finishedTempArr : Array<RegionModel> = []   /** 用于储存请求完成的模型个数 */
    
    public func sendUpdateFileRequest() {
//        HUD.show(.label("loading..."))
        RequestManager.shared.requestCommonDataWith(url: KiOSVersionURL, parameters: nil) { response in
//            HUD.hide()
            
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
//        HUD.show(.label("loading..."))
        RequestManager.shared.requestCommonDataWith(url: HomeLayoutURL, parameters: ["sid":UserInfo.shared.sid]) { [weak self](response) in
//            HUD.hide()
            switch response.result {
            case .success(let value):
                let json          = JSON(value)
                print(json)
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
        reloadBannerClosure?(bannerResultArr)
    }
    
    private func parseHomeLayoutData(regionListArr:Array<JSON>) {
        finishedTempArr.removeAll()
        var regionArr:Array<RegionModel> = []
        for dic in regionListArr {
            /** 首页 ICON 特殊处理 */
            let region = RegionModel()
            let module : String = dic["content_code"].stringValue
            if module == "navigation_module"  {
                region.parseData(json: dic, arrayValues: ["nav_list"])
            } else {
                region.parseData(json: dic)
            }
            regionArr.append(region)
        }
        regionDataArr.removeAll()
        regionDataArr.append(contentsOf: regionArr)
        
        for region in regionDataArr {
            
            /** 开子线程请求数据 */
            DispatchQueue.global().async {[weak self] in
                let contentCode : String = region.content_code!
                if contentCode == "navigation_module" {
                    self?.startLoadingIconData(model:region)
                } else {
                    self?.startLoadingModelDetail(model:region)
                }
            }
        }
    }
    
    private func startLoadingIconData(model:RegionModel) {
        regionDataArr.removeObject(model)
        let iconJsonArr  : Array<Any>       = model.nav_list
        var iconModelArr : Array<IconModel> = []
        for icon in iconJsonArr {
            let iconModel = IconModel()
            iconModel.parseData(json:icon as! JSON)
            iconModelArr.append(iconModel)
        }
        model.nav_list = iconModelArr
        regionDataArr.append(model)
        finishedTempArr.append(model)
    }
    
    private func startLoadingModelDetail(model:RegionModel) {
    
        RequestManager.shared.requestCommonDataWith(url: model.url!, completion: { [weak self](response) in
            
            switch response.result {
            case .success(let value):
                let json          = JSON(value)
                print(json)
                /** 更新数据刷新进度 */
                for region in (self?.regionDataArr)!
                {
                    if region.seq == model.seq
                    {
                        region.dataSourceArr = json["data"].arrayValue
                    }
                }
                
                /** 判断是否解析请求完成 */
                self?.finishedTempArr.append(model)
                
                /** 解析完成后主线程刷新界面 */
                if self?.finishedTempArr.count == (self?.regionDataArr.count)!
                {
                    /** 将数组根据 seq 从小到大排序 */
                    self?.regionDataArr.sort(by: { (lastRegion:RegionModel, nextRegion:RegionModel) -> Bool in
                        let seq0 : Int = lastRegion.seq!.toInt()!
                        let seq1 : Int = nextRegion.seq!.toInt()!
                        return seq0 < seq1
                    })
                    DispatchQueue.main.async { [weak self] in
                        self?.reloadHomeDataClosure?((self?.regionDataArr)!)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
