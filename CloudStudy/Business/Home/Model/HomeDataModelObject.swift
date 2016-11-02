//
//  HomeDataModelObject.swift
//  CloudStudy
//
//  Created by pro on 2016/11/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

typealias UpdateNavigationBarStatusClosurce = (_ offSetY:CGFloat) -> Void

class HomeDataModelObject: NSObject,UITableViewDelegate,UITableViewDataSource {

    public var updateSearchBarStatus : UpdateNavigationBarStatusClosurce?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if updateSearchBarStatus != nil {
            updateSearchBarStatus!(scrollView.offsetY)
        }
    }
    
}
