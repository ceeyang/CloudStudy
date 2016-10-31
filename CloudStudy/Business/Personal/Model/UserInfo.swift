//
//  UserInfo.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfo: NSObject {

    static let shared = UserInfo()
    
    var id           : String!
    var name         : String!
    var head_photo   : String!
    var sid          : String!
    var org_name     : String!
    var company_name : String!
    var job_name     : String!
    var unread_count : String!
    var email        : String!
    var home_tel     : String!
    var office_tel   : String!
    var msn          : String!
    var qq           : String!
    var mobile       : String!
    var kdescription : String!
    var referer      : String!
    var integral     : String!
    var rule_id      : String!
    var doc_rule_id  : String!
    
    func parseUserInfoWithData(Json:JSON) {
        id            = Json["id"]           .stringValue
        name          = Json["name"]         .stringValue
        head_photo    = Json["head_photo"]   .stringValue
        sid           = Json["sid"]          .stringValue
        org_name      = Json["org_name"]     .stringValue
        company_name  = Json["company_name"] .stringValue
        job_name      = Json["job_name"]     .stringValue
        unread_count  = Json["unread_count"] .stringValue
        email         = Json["email"]        .stringValue
        home_tel      = Json["home_tel"]     .stringValue
        office_tel    = Json["office_tel"]   .stringValue
        msn           = Json["msn"]          .stringValue
        qq            = Json["qq"]           .stringValue
        mobile        = Json["mobile"]       .stringValue
        kdescription  = Json["kdescription"] .stringValue
        referer       = Json["referer"]      .stringValue
        integral      = Json["integral"]     .stringValue
        rule_id       = Json["rule_id"]      .stringValue
        doc_rule_id   = Json["doc_rule_id"]  .stringValue
    }
    
    func parseUserInfoFromHistoryData() {
        let data = UserDefaults.standard.object(forKey: kUSER_UserInfoData)
        let json = JSON(data: data as! Data)
        parseUserInfoWithData(Json: json["data"])
    }
}
