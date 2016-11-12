//
//  SearchViewController.swift
//  CloudStudy
//
//  Created by MacOS on 2016/11/12.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    func setupUI() {
        // navigation view
        
        let tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        self.tableView = tableView 
    }
    
    func backAction()  {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SearchViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SearchCellIdentifier")
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
