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
import SwiftyJSON
import EZSwiftExtensions

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

/** 字典转模型: json(SwiftJSON), dic(NSDictionary) */
extension NSObject {
    
    /** 只支持属性全部是 string 类型的模型,当某个属性是 NSDictionary 或者 Array 时, json[key].stringValue 会崩溃 */
    func parseData(json:JSON) {
        
        let dic = json.dictionaryValue as NSDictionary
        let keyArr:Array<String> = dic.allKeys as! Array<String>
        var propertyArr:Array<String> = []
        let hMirror = Mirror(reflecting: self)
        for case let (label?, _) in hMirror.children {
            propertyArr.append(label)
        }
        for property in propertyArr {
            for key in keyArr {
                if key == property {
                    self.setValue(json[key].stringValue, forKey: key)
                }
            }
        }
    }
    
    func parseData(json:JSON,arrayValues:Array<String>?=nil) {
        
        let dic = json.dictionaryValue as NSDictionary
        let keyArr:Array<String> = dic.allKeys as! Array<String>
        var propertyArr:Array<String> = []
        let hMirror = Mirror(reflecting: self)
        for case let (label?, _) in hMirror.children {
            propertyArr.append(label)
        }
        for property in propertyArr {
            for key in keyArr {
                if key == property {
                    for value in arrayValues! {
                        if value == property {
                            self.setValue(json[value].arrayValue, forKey: value)
                            return
                        }
                    }
                    self.setValue(json[key].stringValue, forKey: key)
                }
            }
        }
    }
    
    /** 支持任意类型 */
    func parseData(dic:NSDictionary) {
        
        print(dic)
        let keyArr:Array<String> = dic.allKeys as! Array<String>
        var propertyArr:Array<String> = []
        let hMirror = Mirror(reflecting: self)
        for case let (label?, _) in hMirror.children {
            propertyArr.append(label)
        }
        for property in propertyArr {
            for key in keyArr {
                if key == property {
                    self.setValue(dic[key], forKey: key)
                }
            }
        }
    }
}
