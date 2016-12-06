//
//  ModelExtension.swift
//  CloudStudy
//
//  Created by pro on 2016/12/6.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import Foundation
import ObjectiveC
import SwiftyJSON
import EZSwiftExtensions


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
    
    /** 对模型的 数组类型属性 特殊处理 */
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
    
    /** 对模型的 数组类型属性 和 description属性 特殊处理 */
    func parseData(json:JSON,arrayValues:Array<String>?=nil,descriptionName:String?=nil) {
        
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
                    if arrayValues != nil {
                        for value in arrayValues! {
                            if value == property {
                                self.setValue(json[value].arrayValue, forKey: value)
                                return
                            }
                        }
                    }
                    self.setValue(json[key].stringValue, forKey: key)
                }
                if property == descriptionName {
                    self.setValue(json["description"].stringValue, forKey: property)
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
