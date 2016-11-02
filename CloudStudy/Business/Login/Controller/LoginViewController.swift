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
import EZSwiftExtensions

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
        loginView.siteText?.text    = "zeng"
        loginView.accountText?.text = "zl"
        loginView.paswordText?.text = "zl123456"
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        
        //解决弱引用的三种方式: 
        //①: [unowned self]  跟 _unsafe_unretained 类似  不推荐使用
        //②: 在swift中 有特殊的写法 ,跟OC __weak 相似  [weak self]
        //③: weak var weakSelf = self
        loginView.loginBtnAction = { [weak self] (button) in
            HUD.show(.labeledProgress(title: "", subtitle: "登录中···"))
            self?.loginRequest()
        }
    }
    
    func loginRequest() {
        
        let appSystem       = "iOS ".appendingFormat("%@", UIDevice.systemVersion())
        let dic             = NSMutableDictionary()
        dic["login_id"]     = loginView.accountText?.text
        dic["password"]     = DESUtils.encryptUseDES(loginView.paswordText?.text, key: kPwdKey)
        dic["appMachine"]   = UIDevice.deviceModel()
        dic["appSystem"]    = appSystem
        dic["company_name"] = loginView.siteText?.text
        dic["client_type"]  = 0
   
        RequestManager.shared.requestCommonDataWith(url: LoginURL, parameters: dic) { response in
 
            HUD.hide()
            
            switch response.result {
            case .success(let value):
                let json         = JSON(value)
                let userInofData = response.data
                UserInfo.shared.parseData(json: json["data"])
                UserDefaults.standard.set(true, forKey: kUSER_HADEVERLOGIN)
                UserDefaults.standard.set(userInofData, forKey: kUSER_UserInfoData)
                AppDelegate.shared.buildKeyWindow()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
