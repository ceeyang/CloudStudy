//
//  UserInfo.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

public class UserInfo: NSObject {

    static let shared = UserInfo()
    
    public var id           : String?
    public var name         : String?
    public var head_photo   : String?
    public var sid          : String?
    public var org_name     : String?
    public var company_name : String?
    public var job_name     : String?
    public var unread_count : String?
    public var email        : String?
    public var home_tel     : String?
    public var office_tel   : String?
    public var msn          : String?
    public var qq           : String?
    public var mobile       : String?
    public var kdescription : String?
    public var referer      : String?
    public var integral     : String?
    public var rule_id      : String?
    public var doc_rule_id  : String?
    //public var <#name#> : String?
}
