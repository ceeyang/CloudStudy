//
//  LoginViewController.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {

    var companyStr  : String?
    var accountStr  : String?
    var passwordStr : String?
    
    var loginView = LoginView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        loginView = LoginView()
        loginView.siteText?.text    = "测试部"
        loginView.accountText?.text = "yxc"
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //解决弱引用的三种方式: 
        //①: [unowned self]  跟 _unsafe_unretained 类似  不推荐使用
        //②: 在swift中 有特殊的写法 ,跟OC __weak 相似  [weak self]
        //③: weak var weakSelf = self
        loginView.loginBtnAction = { [weak self] (button) in
            self?.loginRequest()
            button.setTitle("Logining....", for: .normal)
        }
    }
    
    func loginRequest() {
        
        let appSystem = "iOS ".appendingFormat("%lu", UIDevice.current.systemVersion)
        
        let dic             = NSMutableDictionary()
        dic["login_id"]     = loginView.accountText?.text
        //dic["password"]     = password
        dic["password"]     = "XxUHayLsPnI=" //MARK: - 加密算法没实现,密码已经写死...
        dic["appMachine"]   = getDeviceVersion()
        dic["appSystem"]    = appSystem
        dic["company_name"] = loginView.siteText?.text
        dic["client_type"]  = 0
   
        RequestManager.shared.requestCommonDataWith(url: LoginURL, parameters: dic) { [weak self] response in
 
            if (response.result.value != nil) {
                let json = JSON(data: response.data!)
                print("\(json)")
            } else {
                print("请求失败: \(response.description)")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
