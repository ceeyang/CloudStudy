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

class RequestManager: NSObject {

    static let shared = RequestManager()
    
    func requestCommonDataWith(url:String,parameters:NSDictionary,completion:@escaping (DataResponse<Any>) -> Void){
        let dic  = parameters.JSONString() as? [String : AnyObject]
        Alamofire.request(url, method: .post, parameters:dic, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: completion)
    }
}
