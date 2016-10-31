import Foundation
import SwiftyJSON

class ModelFoundation {
    
    static let set = NSSet(array: [NSURL.classForCoder(),
                                   NSDate.classForCoder(),
                                   NSValue.classForCoder(),
                                   NSData.classForCoder(),
                                   NSError.classForCoder(),
                                   NSArray.classForCoder(),
                                   NSDictionary.classForCoder(),
                                   NSString.classForCoder(),
                                   NSAttributedString.classForCoder()
                                   ])
    static let bundlePath = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    
    /*** 判断某个类是否是 Foundation中自带的类 */
    class func isClassFromFoundation(c:AnyClass) -> Bool {
        var result = false
        if c == NSObject.classForCoder() {
            result = true
        } else {
            set.enumerateObjects({ (foundation, stop) in
                if c.isSubclass(of: foundation as! AnyClass) {
                    result = true
                    stop.initialize(to: true)
                }
            })
        }
        return result
    }
    
    class func getType( code:String) -> String {
        var code = code
        if !code.contains(bundlePath) {
            return ""
        }
        code = code.components(separatedBy: "\"")[1]
        if let range:Range = code.range(of: bundlePath) {
            code = code.substring(from: range.upperBound)
            var numStr = ""
            for c:Character in code.characters {
                if c <= "9" && c >= "0" {
                    numStr += String(c)
                }
            }
            if let numRange = code.range(of: numStr) {
                code = code.substring(from: numRange.upperBound)
            }
            return bundlePath + "." + code
        }
        return ""
    }
}

@objc public protocol DictModelProtocol {
    static func customClassMapping() -> [String : String]?
}

extension NSObject {
    
    class func objectWith(KeyValuesDic:NSDictionary) -> AnyObject?{
        if ModelFoundation.isClassFromFoundation(c: self) {
            print("只有自定义模型类才可以字典转模型")
            assert(true)
            return nil
        }
        
        //let obj:AnyObject = self.init()
        var cls:AnyClass  = self.classForCoder()
        //let t = (self.classForCoder() as! NSObject.Type).init()
        
        while("NSObject" !=  "\(cls)"){
            var count:UInt32 = 0
            let properties   = class_copyPropertyList(cls, &count)
            for i in 0..<count {
                let property = properties?[Int(i)]
                let propertyType = String(cString: property_getAttributes(property))
                let propertyKey  = String(cString: property_getName(property))
                if propertyKey  == "description"{ continue  }
                var value:AnyObject! = KeyValuesDic.object(forKey: propertyKey) as AnyObject
                if value == nil { continue }
                let valueType = "\(value.classForCoder)"
                if valueType == "NSDictionary" {
                    let subModelStr:String = ModelFoundation.getType(code: propertyType)
                    if subModelStr == "" {
                        print("你定义的模型与字典不匹配。 字典中的键\(propertyKey)  对应一个自定义的 模型")
                        assert(true)
                    }
                    if let subModelClass = NSClassFromString(subModelStr) {
                        value = subModelClass.objectWith(KeyValuesDic: value as! NSDictionary)
                    }
                } else if valueType == "NSArray" {
                    if self.conforms(to: DictModelProtocol.self) {
                        if var subModelClassName = cls.customClassMapping()?[propertyKey] {
                            subModelClassName = ModelFoundation.bundlePath + "." + subModelClassName
                            if let subModelClass = NSClassFromString(subModelClassName) {
                                value = subModelClass.objectArrayWith(KeyValuesArray: value as! NSArray)
                            }
                        }
                    }
                }
                self.setValue(value, forKey: propertyKey)
            }
            free(properties)
            cls = cls.superclass()!
        }
        return self
    }
    
    
    class func objectArrayWith(KeyValuesArray:NSArray) -> NSArray? {
        if KeyValuesArray.count == 0 {
            return nil
        }
        var result = [AnyObject]()
        for item in KeyValuesArray {
            let type = "\((item as AnyObject).classForCoder)"
            if type == "NSDictionary" {
                if let model = objectWith(KeyValuesDic: item as! NSDictionary) {
                    result.append(model)
                }
            } else if type == "NSArray" {
                if let model = objectArrayWith(KeyValuesArray: item as! NSArray)  {
                    result.append(model)
                }
            } else {
                result.append(item as AnyObject)
            }
        }
        if result.count == 0 {
            return nil
        } else {
            return result as NSArray?
        }
    }
}


/******************************************************************************************************************/

//
//  NSObject+Add.swift
//  ZZJModel
//
//  Created by duzhe on 16/1/22.
//  Copyright © 2016年 dz. All rights reserved.
//

import Foundation


/**
 数据类型
 */
public enum zz_type :Int{
    case Number
    case String
    case Bool
    case Array
    case Dictionary
    case Null
    case Unknown
}

/*
 let queue = DispatchQueue(label: "com.test.myqueue")
 queue.asynchronously {
 print("Hello World")
 }
*/

private let zz_queue = DispatchQueue(label:"zz_zzjmodel_queie_serial")
extension NSObject{
    
    /**
     任意类型  如果传入的是任意类型 主动转成字典 如果不成功返回空对象
     
     - parameter obj: 任意对象
     
     - returns: 模型
     */
    static func zz_objToModel(obj:AnyObject?)->NSObject?{
        if let dic = obj as? [String:AnyObject]{
            return zz_dicToModel(dic: dic)
        }
        return nil
    }
    
    /**
     字典转模型
     
     - parameter dic: 字典
     - returns: 模型
     */
    static func zz_dicToModel(dic:[String:AnyObject])->NSObject?{
        if dic.first == nil {
            return nil
        }
        var t = (self.classForCoder() as! NSObject.Type).init()
        let properties = t.zz_modelPropertyClass()
        for (k,v) in dic{
            print("K:\(k),V:\(v)")
            if t.zz_getVariableWithClass(cla: self.classForCoder(), varName: k){ //如果存在这个属性
                if t.zz_isBasic(type: t.zz_getType(v: v)){
                    //                    print(t.classForCoder)
                    //基础类型 可以直接赋值
                    //                    print("\(k)--\(v)--\(t.zz_getType(v))")
                    t.setValue(v,forKey: k)
                }else{
                    //(t as! self.classForCoder()).setValue(v as! String, forKey: k)
                    return t
                    //MARK: - --------------------
                    //复杂类型
                    let type = t.zz_getType(v: v)
                    if type == .Dictionary{
                        //是一个对象类型
                        if let dic1 = v as? [String : AnyObject]{
                            
                            //if t.respondsToSelector("zz_modelPropertyClass"){
                                if let properties = properties{
                                    if  t.value(forKey: k) == nil{
                                        //初始化
                                        let obj = (properties[k] as! NSObject.Type).init()
                                        t.setValue(obj, forKey: k)
                                    }
                                //}
                            }
                            if let obj = t.value(forKey: k){
                                (obj as AnyObject).setDicValue(dic1: dic1)//有对象就递归
                            }
                        }
                    }else if type == .Array{
                        //数组类型
                        if let arr = v as? [AnyObject]{
                            if !arr.isEmpty {
                                if t.zz_isBasic(type: t.zz_getType(v: arr.first!)) {
                                    //数组中的内容是基本类型
                                    t.setValue(arr, forKey: k)
                                }else{
                                    if t.zz_getType(v: arr.first!) == .Dictionary{
                                        //对象数组
                                        var objs:[NSObject] = []
                                        for dic in arr{
                                            if let properties = properties{
                                                let obj = (properties[k] as! NSObject.Type).init()
                                                objs.append(obj)
                                                zz_queue.async {
                                                    //串行对列执行
                                                    obj.setDicValue(dic1: dic as! [String : AnyObject])
                                                }
                                            }
                                        }
                                        t.setValue(objs, forKey: k)
                                    }
                                }
                            }
                        }
                    } else if type == .Unknown {
                        t.setValue(v, forKey: k)
                    }
                }
                
            }
        }
        return t
    }
    
    
    /**
     逐级递归 遍历赋值给对象
     
     - parameter dic1: 字典
     */
    func setDicValue(dic1:[String : AnyObject]){
        for (k,v) in dic1{
            
            if self.zz_getVariableWithClass(cla: self.classForCoder, varName: k){
                //判断是否存在这个属性
                if self.zz_isBasic(type: self.zz_getType(v: v)){
                    //设置基本类型
                    if self.zz_getType(v: v) == .Bool{
                        //TODO: -Bool类型怎么处理  不懂
                        //                      self.setValue(Bool(v as! NSNumber), forKey: k)
                        
                    }else{
                        self.setValue(v, forKey: k)
                    }
                }else if self.zz_getType(v: v) == .Dictionary{
                    if let dic1 = v as? [String : AnyObject]{
                        //if self.respondsToSelector("zz_modelPropertyClass"){
                            if let properties = self.zz_modelPropertyClass(){
                                if  self.value(forKey: k) == nil{
                                    //初始化
                                    let obj = (properties[k] as! NSObject.Type).init()
                                    self.setValue(obj, forKey: k)
                                }
                            //}
                        }
                        if let obj = self.value(forKey: k){
                            (obj as AnyObject).setDicValue(dic1:dic1) //递归
                        }
                    }
                }
                
            }
        }
    }
    
    
    /**
     判断类型
     
     - parameter v: 参数
     
     - returns: 类型
     */
    private func zz_getType(v:AnyObject)->zz_type{
        print("\(v)")
        switch v{
        case let number as NSNumber:
            if number.zz_isBool {
                return .Bool
            } else {
                return .Number
            }
        case _ as String:
            return .String
        case _ as NSNull:
            return .Null
        case _ as [AnyObject]:
            return .Array
        case _ as [String : AnyObject]:
            return .Dictionary
        default:
            return .Unknown
        }
    }
    
    
    /**
     是否为基础类型
     
     - parameter type: 类型
     
     - returns: true/false
     */
    private func zz_isBasic(type:zz_type)->Bool{
        if type == .Bool || type == .String || type == .Number {
            return true
        }
        return false
    }
    
    /**
     留给子类有实体属性的去继承
     
     - returns: k , 实体
     */
    func zz_modelPropertyClass()->[String:AnyClass]?{
        return nil
    }
    
    /**
     判断对象中是否包含某个属性
     
     - parameter cla:     类
     - parameter varName: 变量名
     
     - returns: bool
     */
    func zz_getVariableWithClass(cla:AnyClass , varName:String)->Bool{
        var outCount:UInt32 = 0
        let ivars = class_copyIvarList(cla, &outCount)
        for i in 0..<outCount{
            let property = ivars?[Int(i)]
            let keyName = String(cString:ivar_getName(property))
            if keyName == varName{
                free(ivars)
                return true
            }
        }
        free(ivars)
        return false
    }
    
}

private let zz_trueNumber = NSNumber(value: true)
private let zz_falseNumber = NSNumber(value: false)
private let zz_trueObjCType = String(cString:zz_trueNumber.objCType)
private let zz_falseObjCType = String(cString:zz_falseNumber.objCType)
// MARK: - 判断是否为bool
extension NSNumber {
    var zz_isBool:Bool {
        get {
            let objCType = String(cString:self.objCType)
            if (self.compare(zz_trueNumber) == ComparisonResult.orderedSame && objCType == zz_trueObjCType)
                || (self.compare(zz_falseNumber) == ComparisonResult.orderedSame && objCType == zz_falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}

