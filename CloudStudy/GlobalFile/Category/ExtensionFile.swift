//
//  ExtensionFile.swift
//  ZhiXueYun
//
//  Created by pro on 16/4/25.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import Foundation
import ObjectiveC



//MARK: - String
extension String {
    var length: Int {
        return characters.count
    }  // Swift 2.0\
    
    func checkEmpty() -> String {
        if self.length == 0 {
            return ""
        }
        return self
    }
    
    var isNotEmpty: Bool {
        if length == 0 { return false}
        else { return true }
    }
    
}

//MARK: - NSDictionary
extension NSDictionary{
    
    public func JSONString() -> NSDictionary {
        
        let data = try!JSONSerialization.data(withJSONObject: self, options: [])
        let strJson=NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let dict:NSDictionary = ["json":strJson!]
        return dict
    }
}



/*------------------------- 我是萌萌哒的分割线 -------- #^_^# ---------------------------------------*/
//MARK: - UIButton

var ActionBlockKey : UInt8       = 0
typealias buttonActionClosure    = (_ sender:UIButton)->Void

class ActionBlockWrapper: NSObject {
    var block :buttonActionClosure
    init(block: @escaping buttonActionClosure) {
        self.block = block
    }
}

extension UIButton {
    
    func addAction(block:@escaping buttonActionClosure) {
        objc_setAssociatedObject(self, &ActionBlockKey, ActionBlockWrapper(block:block),  objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(block_handleAction(sender:)), for: .touchUpInside)
    }
    
    func block_handleAction(sender:UIButton) {
        let wrapper = objc_getAssociatedObject(self, &ActionBlockKey) as! ActionBlockWrapper
        wrapper.block(sender)
        
    }
}

/*------------------------- 我是萌萌哒的分割线 -------- #^_^# ---------------------------------------*/
extension Collection {
    
    var isNotEmpty: Bool {
        if self.isEmpty {
            return false
        } else {
            return true
        }
    }
}
