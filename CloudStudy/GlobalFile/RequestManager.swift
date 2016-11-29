//
//  RequestManager.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/** 默认请求参数 */
let kPageSize = 10

class RequestManager: NSObject {

    static let shared = RequestManager()
    
    /**
     *  请求公共数据,只返回code 为0000 的情况,对请求失败后的错误代码进行了处理
     */
    func requestCommonDataWith(url:String,parameters:NSDictionary? = nil,completion: @escaping (DataResponse<Any>) -> Void){
        let dic  = parameters?.JSONString() as? [String : AnyObject]
        Alamofire.request(url, method: .post, parameters:dic, encoding: URLEncoding.default, headers: nil).responseJSON { [weak self](response) in
            
            switch response.result {
            case .success(let value):
                let json         = JSON(value)
                if json["code"].stringValue == "0000" {
                    completion(response)
                } else {
                    self?.hanedleRequestErrorWith(json: json)
                }
                break
            case .failure(let error):
                printLog("Request Failed Url:\(url) with errorInfo:\(error)")
                break
            }
        }
    }
    
    /** 错误处理 */
    func hanedleRequestErrorWith(json:JSON) {
        let code = json["code"].stringValue
        let msg  = json["msg"].stringValue
        
        if code == "0000" {
            return
        } else if  code == "0003" {
            print(msg)
            HUD.flash(.label(msg), delay: 2.0)
            UserDefaults.standard[kUSER_HADEVERLOGIN] = false
            AppDelegate.shared.buildKeyWindow()
        } else if  code == "0504" {
            let time = json["data"]["time"].stringValue
            let client_type = json["data"]["client_type"].stringValue
            var mobileType  = ""
            if client_type == "0" { // ios
                mobileType = "iOS"
            } else if client_type == "6" {
                mobileType = "Android"
            } else {
                mobileType = "UnKnown"
            }
            HUD.flash(.label("Your acount has logined by anthor \(mobileType) device at \(time)"), delay: 2.0)
            UserDefaults.standard[kUSER_HADEVERLOGIN] = false
            AppDelegate.shared.buildKeyWindow()
        } else {
            print(msg)
            HUD.flash(.label(msg), delay: 2.0)
        }
    }
}
