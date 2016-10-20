//
//  loginView.swift
//  CloudStudy
//
//  Created by pro on 2016/10/20.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SnapKit

typealias buttonActionClosure = (_ sender:UIButton)->Void

enum LoginViewBtnTag : Int {
    case Login = 0,FindPwd,Company,Telphone,WebSite
}

class loginView: UIView {

    public var siteText    : UITextField?
    public var accountText : UITextField?
    public var paswordText : UITextField?
    
    public var loginBtn    : UIButton?
    public var pasBtn      : UIButton?
    
    public var loginBtnAction : buttonActionClosure?
    public var findPwdBtnAction : buttonActionClosure?
    
    var labelTitleArr  = ["企业名称","账    号","密    码"]
    var placeHolderArr = ["请输入企业名称","账号/邮箱/手机号","请输入密码"]
    var infoTitlesArr  = ["深圳知学云科技有限公司","400-656-8595"]
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        /** Logo Image */
        let logoImage = UIImageView(image: UIImage(named: "login_logo"))
        logoImage.contentMode = .scaleAspectFill
        addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(40)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        let height : CGFloat = 45.0
        let inputAreaBackgroundView = UIView()
        inputAreaBackgroundView.backgroundColor = UIColor.clear
        addSubview(inputAreaBackgroundView)
        inputAreaBackgroundView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.height.equalTo(CGFloat(labelTitleArr.count) * height)
        }
        
        var ySpace : CGFloat = 0
        for i in 0..<labelTitleArr.count {
            
            /** 条目背景 */
            let itemBackgroundView = UIView()
            itemBackgroundView.backgroundColor = UIColor.clear
            inputAreaBackgroundView.addSubview(itemBackgroundView)
            itemBackgroundView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self)
                make.top.equalTo(inputAreaBackgroundView.snp.top).offset(CGFloat(i) * height + ySpace)
                make.height.equalTo(height)
            })
            
            /** 标题 */
            let titleLabel = UILabel()
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor       = RGB(r: 51, g: 51, b: 51)
            titleLabel.font            = UIFont.systemFont(ofSize: 17)
            titleLabel.text            = labelTitleArr[i]
            itemBackgroundView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(itemBackgroundView.snp.left).offset(20)
                make.top.bottom.equalTo(itemBackgroundView)
                make.width.greaterThanOrEqualTo(90)
            })
            
            /** 输入框 */
            let textField               = UITextField()
            textField.font              = UIFont.systemFont(ofSize: 17)
            textField.textColor         = RGB(r: 51, g: 51, b: 51)
            textField.backgroundColor   = UIColor.clear
            itemBackgroundView.addSubview(textField)
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel.snp.right)
                make.top.bottom.equalTo(itemBackgroundView)
                make.right.equalTo(itemBackgroundView.snp.right).offset(-10)
            })
            
            let placeHolder = placeHolderArr[i]
            if i == 0 {
                siteText      = textField
            } else if i == 1 {
                accountText   = textField
            } else if i == 2 {
                textField.isSecureTextEntry = true
                textField.clearButtonMode   = .always
                paswordText   = textField
            }
            let attribut = [NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:RGB(r: 211, g: 211, b: 211)]
            let attributedStr = NSMutableAttributedString(string: placeHolderArr[i])
            attributedStr.addAttributes(attribut, range: NSMakeRange(0, placeHolder.characters.count))
            textField.attributedPlaceholder = attributedStr
            
            ySpace += 1
        }
        
        /** Login Button */
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.setBackgroundImage(UIImage(named:"login_button_n"), for: .normal)
        loginBtn.setBackgroundImage(UIImage(named:"login_button_c"), for: .highlighted)
        loginBtn.layer.cornerRadius = 2.5
        loginBtn.clipsToBounds = true;
        loginBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        loginBtn.tag = LoginViewBtnTag.Login.rawValue
        self.loginBtn = loginBtn
        
        /** Find Pwd Button */
        let pasBtn = UIButton(type: .custom)
        pasBtn.setTitleColor(RGB(r: 136, g: 136, b: 136), for: .normal)
        pasBtn.setTitle("Find Passcode", for: .normal)
        pasBtn.backgroundColor = UIColor.clear
        pasBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        pasBtn.tag = LoginViewBtnTag.FindPwd.rawValue
        pasBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        addSubview(pasBtn)
        pasBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(loginBtn.snp.bottom)
            make.height.equalTo(height)
        }
        self.pasBtn = pasBtn
        
        /** 版权信息 */
        let buttonHeight : CGFloat = 20
        let infoBackgroundView = UIView()
        infoBackgroundView.backgroundColor = UIColor.clear
        addSubview(infoBackgroundView)
        infoBackgroundView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-15)
            make.height.equalTo(CGFloat(infoTitlesArr.count)*buttonHeight)
        }
        for i in 0..<infoTitlesArr.count {
            let button = UIButton(type: .custom)
            button.backgroundColor = UIColor.clear
            button.setTitleColor(RGB(r: 204, g: 204, b: 204), for: .normal)
            button.setTitle(infoTitlesArr[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            infoBackgroundView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.right.equalTo(infoBackgroundView)
                make.top.equalTo(infoBackgroundView.snp.top).offset(CGFloat(i)*buttonHeight)
                make.height.equalTo(buttonHeight)
            })
            if i == 0 {
                button.tag = LoginViewBtnTag.Company.rawValue
            } else if i == 1 {
                button.tag = LoginViewBtnTag.Telphone.rawValue
            }
        }
        
    }
    
    func buttonAction(sender:UIButton) {
        let tag = sender.tag
        switch tag {
        case LoginViewBtnTag.Login.rawValue:
            if (loginBtnAction != nil) {
                loginBtnAction!(sender)
            }
            break
            
        case LoginViewBtnTag.FindPwd.rawValue:
            if (findPwdBtnAction != nil) {
                findPwdBtnAction!(sender)
            }
            break
            
        case LoginViewBtnTag.Company.rawValue:
            break
            
        case LoginViewBtnTag.Telphone.rawValue:
            break
            
        case LoginViewBtnTag.WebSite.rawValue:
            break
            
        default:
            break
        }
    }
    
}
