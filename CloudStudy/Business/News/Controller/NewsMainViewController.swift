//
//  NewsMainViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/11/5.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class NewsMainViewController: UIViewController {

    private var header        : MJRefreshNormalHeader!
    private var footer        : MJRefreshAutoNormalFooter!
    private var tableView     : UITableView!
    private var newsData      : Array<Any> = []
    private var dataSource    : BaseTableDataSource?
    private var pageSize      : Int = 1
    private var pageNumber    : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addRefresh()
    }
    
    func setupUI() {
        title = "News"
        
        /** main scrollview */
        tableView = UITableView(frame:view.frame)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = nil
        tableView.isScrollEnabled = true
        tableView.backgroundView  = nil
        tableView.backgroundColor = UIColor.clear
        tableView.register(HomeIconCell.self, forCellReuseIdentifier: kHomeIconCellReuseIdentifier)
        view.addSubview(tableView)
    }

    func addRefresh() {
        header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.pageNumber = 1
            self?.requestNewsData(isHeaderRefresh:true)
            })
        tableView.mj_header = header
        
        footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.pageNumber += 1
            self?.requestNewsData(isHeaderRefresh:false)
            })
        tableView.mj_footer = footer
        
        header.beginRefreshing()
    }
    
    func requestNewsData(isHeaderRefresh:Bool) {
        
        HUD.show(.label("Loading..."))
        
        let dic           = NSMutableDictionary()
        dic["sid"]        = UserInfo.shared.sid
        dic["pageNumber"] = 1
        dic["pageSize"]   = 1

        RequestManager.shared.requestCommonDataWith(url: NewsListURL, parameters: dic) { [weak self](response) in
            
            HUD.hide()
            self?.endRefresh()
            
            switch response.result {
            case .success(let value):
                let json         = JSON(value)
                let list  = json["data"]["list"].arrayValue
                if isHeaderRefresh {
                    self?.newsData.removeAll()
                }
                for dic in list {
                    let model = NewsModel()
                    model.parseData(json: dic)
                    self?.newsData.append(model)
                }
                self?.reloadTableViewWith((self?.newsData)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reloadTableViewWith(_ data:Array<Any>) {
        if data.count == 0 {
            
        } else {
            
        }
        
        let clourse  = {(cell:BaseTableViewCell, model:NewsModel) in
            
        }
        dataSource = BaseTableDataSource(items: data, identifer: "NewsListCellIdentifier", cellConfigureClourse: clourse as! TableViewCellConfigureClourse)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func endRefresh() {
        if header.isRefreshing() {
            header.endRefreshing()
        }
        if footer.isRefreshing() {
            footer.endRefreshing()
        }
    }
    
    deinit {
        header = nil
        footer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
