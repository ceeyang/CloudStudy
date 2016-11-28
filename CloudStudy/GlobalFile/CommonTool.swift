//
//  CommonTool.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

let kScreenWidth  : CGFloat = UIScreen.main.bounds.size.width
let kScreenHeight : CGFloat = UIScreen.main.bounds.size.height

//MARK: - Public Method
func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return RGBA(r: r, g: g, b: b, a: 1.0)
}

func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    let range = file.range(of: "CloudStudy")
    let path  = file.substring(from: (range?.lowerBound)!)
    print("\(path)[\(line)], \(method): \(message)")
}

func getDeviceVersion () -> String? {
    let name = UnsafeMutablePointer<utsname>.allocate(capacity: 1)
    uname(name)
    let machine = withUnsafePointer(to: &name.pointee.machine, { (ptr) -> String? in
        let int8Ptr = unsafeBitCast(ptr, to: UnsafePointer<CChar>.self)
        return String(cString: int8Ptr)
    })
    name.deallocate(capacity: 1)
    if let deviceString = machine {
        switch deviceString {
        //iPhone
        case "iPhone1,1":                 return "iPhone 1G"
        case "iPhone1,2":                 return "iPhone 3G"
        case "iPhone2,1":                 return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2":    return "iPhone 4"
        case "iPhone4,1":                 return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2":    return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":    return "iPhone 5C"
        case "iPhone6,1", "iPhone6,2":    return "iPhone 5S"
        case "iPhone7,1":                 return "iPhone 6 Plus"
        case "iPhone7,2":                 return "iPhone 6"
        case "iPhone8,1":                 return "iPhone 6s"
        case "iPhone8,2":                 return "iPhone 6s Plus"
        case "iPhone9,1":                 return "iPhone 7 Plus"
        case "iPhone9,2":                 return "iPhone 7"
        default:
            return deviceString
        }
    } else {
        return nil
    }
}
