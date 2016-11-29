//
//  DirectoryTableView.swift
//  CloudStudy
//
//  Created by pro on 2016/11/29.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

let DirectoryCellReusableIdentifier = "DirectoryCellReusableIdentifier"

class DirectoryTableView: UIView {

    var mTableView        : UITableView?
    var directoryModelArr : Array<DirectoryModel> = []
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createTableViewWith(_ directoryModelArr:Array<DirectoryModel>) {
        self.directoryModelArr = directoryModelArr
        setupUI()
    }
    
    fileprivate func setupUI() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DirectoryCellReusableIdentifier)
        mTableView = tableView
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        tableView.reloadData()
    }
}

extension DirectoryTableView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryModelArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: DirectoryCellReusableIdentifier, for: indexPath)
        if directoryModelArr.count > 0 {
            let model = directoryModelArr[indexPath.row]
            cell.textLabel?.text = model.name
            if model.subDirectorys.count > 0 {
                cell.accessoryType = .disclosureIndicator
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
