
//
//  BaseTableDataSource.swift
//  CloudStudy
//
//  Created by pro on 2016/11/7.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

typealias TableViewCellConfigureClourse = (_ Cell:UITableViewCell,_ Items:Any) -> Void

public class BaseTableDataSource: NSObject,UITableViewDataSource {

    public  var dataSource:Array<Any> = []
    private var cellConfigureClourse : TableViewCellConfigureClourse?
    private var cellIdentifier   : String?
    
    convenience init(items:Array<Any>,identifer:String,cellConfigureClourse:@escaping TableViewCellConfigureClourse) {
        self.init()
        self.dataSource           = items
        self.cellIdentifier       = identifer
        self.cellConfigureClourse = cellConfigureClourse
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        let item = dataSource[indexPath.row]
        cellConfigureClourse!(cell,item)
        return cell
    }
    
}
