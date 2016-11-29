//
//  DocDirectoryViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/11/27.
//  Copyright © 2016年 daisy. All rights reserved.
//

import SwiftyJSON
import UIKit

let CategoryCellReusableIdentifier = "CategoryCellReusableIdentifier"

class DocDirectoryViewController: UIViewController {

    var mScrollView  : UIScrollView?
    /** 储存当前层级 */
    var currentLevel : Int = 0
    
    /** 储存当前层次以及模型的字典, key 为当前层次, value 为当前层次对应的目录数组 */
    var directoryData  : [Int:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollview()
        loadCategoryInfo()
    }

    fileprivate func setupScrollview() {
        
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.backgroundColor = kAppBaseColor
        view.addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        mScrollView = scrollview
    }
    
    
    
    fileprivate func loadCategoryInfo() {
        
        HUD.show(.label("loading..."))
        
        let parameters : NSMutableDictionary = [:]
        parameters["sid"]             = UserInfo.shared.sid
        
        RequestManager.shared.requestCommonDataWith(url: DocCategoryURL, parameters: parameters) { [weak self](response) in
            HUD.hide()
            
            switch response.result {
            case .success(let value):
                let json          = JSON(value)
                let directoryArr  = json["data"].arrayValue
                self?.parseDirectoryModelWith(directoryArr)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func parseDirectoryModelWith(_ directoryArr:Array<JSON>) {
        
        var totalDirectoryArr : Array<DirectoryModel> = []
        
        for dic in directoryArr {
            let directory = DirectoryModel()
            directory.parseData(json: dic)
            totalDirectoryArr.append(directory)
        }
        
        /** 解析每层数据后剩下的目录数组 */
        var beLeftOverArr  : Array<DirectoryModel> = []
        beLeftOverArr.append(contentsOf: totalDirectoryArr)
        
        /** 循环解析数组模型,当前数组,parseLeveIndex为当前解析层次,将层次作为 key 储存每层的目录数组 */
        for parseLeveIndex in 0..<totalDirectoryArr.count {
            
            /** 当前目录数组,获取到属于当前目录的模型时,添加到该数组,然后根据parseLeveIndex值作为当前层次储存到directoryData */
            var currentDirectoryArr  : Array<DirectoryModel> = []
            
            /** 解析当前层次下数据后剩下数据的临时数组,等待当前数据解析完毕后赋值到 beLeftOverArr */
            var currentParseTempArr  : Array<DirectoryModel> = []
            
            /** 当前层次中解析的索引 */
            var beLeftOverIndex      : Int = 0
            
            /** 如果剩下的目录数组为空时候,结束循环 */
            if beLeftOverArr.count <= 0
            {
                createFirstTableView()
                break
            }
            
            for currentParseModel in beLeftOverArr {
                
                currentParseModel.level = parseLeveIndex.toString
                
                /** 第一层, 特殊处理,根据 parent_id 为空进行判断 */
                if parseLeveIndex == 0
                {
                    if (currentParseModel.parent_id?.isBlank)! {
                        
                        currentDirectoryArr.append(currentParseModel)
                    } else {
                        
                        currentParseTempArr.append(currentParseModel)
                    }
                }
                /** 非第一层,遍历上一层目录数组,再遍历当前剩余目录数组,判断规则为: 当前模型的 parent_id == 上一层模型数组中的 id */
                else
                {
                    /** 循环上一层的目录数组 */
                    let lastModelArr = directoryData[parseLeveIndex-1] as! Array<DirectoryModel>
                    
                    /** 防止多次循环添加当前模型 currentParseModel */
                    var isFirstAdd = true
                    
                    var lastModelParseIndex : Int = 0
                    
                    for lastModel in lastModelArr {
                        
                        lastModelParseIndex += 1
                        
                        /** 如果剩下目录数组中的模型的 parent_id 与上一层目录数组中的模型的 id 相同,则添加对应模型到当前目录数组 */
                        if currentParseModel.parent_id == lastModel.id
                        {
                            currentDirectoryArr.append(currentParseModel)
                            lastModel.subDirectorys.append(currentParseModel)
                        }
                        else
                        {
                            if isFirstAdd {
                                isFirstAdd = false
                                currentParseTempArr.append(currentParseModel)
                            }
                        }
                    }
                }
                
                /** 当前层次解析完毕,从新给剩下模型数组赋值 */
                if beLeftOverIndex == beLeftOverArr.count - 1 {
                    beLeftOverArr.removeAll()
                    beLeftOverArr.append(contentsOf: currentParseTempArr)
                }
                
                beLeftOverIndex   += 1
            }
            
            /** 将当前解析层次parseLeveIndex 作为 key, 当前层次下模型数组 currentDirectoryArr 作为 value, 储存到整个模型字典 directoryData 里面*/
            directoryData[parseLeveIndex] = currentDirectoryArr
            currentDirectoryArr.removeAll()
        }
    }
    
    fileprivate func createFirstTableView() {
        
        let firstModelArr = directoryData[0] as! Array<DirectoryModel>
        let rootModel     = firstModelArr.first
        
        createTableView(with: rootModel!)
    }
    
    fileprivate func createTableView(with directoryModel:DirectoryModel) {
        
        let currentIndex             = directoryModel.level?.toInt()
        let tableViewWidth : CGFloat = kScreenWidth/2
        
        let directoryTableView = DirectoryTableView()
        
        mScrollView?.addSubview(directoryTableView)
        directoryTableView.snp.makeConstraints { (make) in
            make.top.equalTo((mScrollView?.snp.top)!)
            make.left.equalTo((mScrollView?.snp.left)!).offset(tableViewWidth * CGFloat(currentIndex!))
            make.width.equalTo(tableViewWidth)
            make.height.equalTo(kScreenHeight - 64 - 44)
        }
        
        directoryTableView.createTableViewWith(directoryModel.subDirectorys as! Array<DirectoryModel>)
    }
    
    
    
    fileprivate func getAllDirectoryModel(_ lastModelName:DirectoryModel) -> DirectoryModel {
        let allDirectoryModel  = DirectoryModel()
        allDirectoryModel.name = "All"
        return allDirectoryModel
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
