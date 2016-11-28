//
//  BaseTableViewDataObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/27.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

typealias BaseTableviewDataObjectCellDiddSelectedClourse = (_ item : Any) -> Void
typealias BaseTableviewDataObjectCellConfigClourse       = (_ cell : Any, _ item:Any) -> Void

class BaseTableViewDataObject: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    public var didSelectedAction: BaseTableviewDataObjectCellDiddSelectedClourse?
    public var cellConfigClourse: BaseTableviewDataObjectCellConfigClourse?
    
    fileprivate var itemsArr:Array<Any> = []
    fileprivate var reuseIdentifierStr:String?
    
    convenience init(_ itemsArr:Array<Any> , reuseIdentifierStr:String) {
        self.init()
        self.itemsArr           = itemsArr
        self.reuseIdentifierStr = reuseIdentifierStr
    }
    
    convenience init(_ itemsArr:Array<Any>, reuseIdentifierStr:String, cellConfigClourse:@escaping BaseTableviewDataObjectCellConfigClourse) {
        self.init()
        self.itemsArr           = itemsArr
        self.reuseIdentifierStr = reuseIdentifierStr
        self.cellConfigClourse  = cellConfigClourse
    }
    
    public func updateTableViewDataSourceWith(_ itemsArr:Array<Any>) {
        self.itemsArr = itemsArr
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifierStr)
        let item = itemsArr[indexPath.row]
        if (cellConfigClourse != nil) {
            cellConfigClourse!(cell,item)
        }
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (didSelectedAction != nil) {
            let item = itemsArr[indexPath.row]
            didSelectedAction!(item)
        }
    }
}
