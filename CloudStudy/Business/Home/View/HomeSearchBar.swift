
//
//  HomeSearchBar.swift
//  CloudStudy
//
//  Created by pro on 2016/10/25.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class HomeSearchBar: UIView {

    var kInputView      : UIButton!
    var kBackgroundImg  : UIImageView!
    
    var kmessageBtn     : UIButton!
    var kQrCodeBtn      : UIButton!
    var kSearchBtn      : UIButton!
    
    var qrCodeBtnAction  : buttonActionClosure?
    var messageBtnAction : buttonActionClosure?
    var searchBtnAction  : buttonActionClosure?
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI -
    func setupUI() {
        
        /** 背景图片 */
        kBackgroundImg = UIImageView(image: UIImage(named:"common_actionbar_bg@2x"))
        kBackgroundImg.alpha = 0
        self.addSubview(kBackgroundImg)
        kBackgroundImg.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        /** 二维码扫描按钮 */
        kQrCodeBtn     = UIButton()
        kQrCodeBtn.setImage(UIImage(named:"new_nav_scan"), for: .normal)
        kQrCodeBtn.setImage(UIImage(named:"new_nav_scan_pre"), for: .selected)
        addSubview(kQrCodeBtn)
        kQrCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBackgroundImg.snp.left)
            make.top.equalTo(kBackgroundImg.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        /** 消息按钮 */
        kmessageBtn     = UIButton()
        let imageName =  UserInfo.shared.unread_count == "0" ? "new_nav_bell" : "new_nav_bell_message"
        kmessageBtn.setImage(UIImage(named:imageName), for: .normal)
        addSubview(kmessageBtn)
        kmessageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(kBackgroundImg.snp.right)
            make.top.equalTo(kBackgroundImg.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        /** 搜索框 */
        kInputView = UIButton()
        kInputView.setBackgroundImage(UIImage(named:"homepage_black_half_bg"), for: .normal)
        kInputView.setImage(UIImage(named:"new_head_search_right"), for: .normal)
        kInputView.setTitle("搜一搜", for: .normal)
        kInputView.layer.masksToBounds = true
        kInputView.layer.cornerRadius  = 5
        addSubview(kInputView)
        kInputView.snp.makeConstraints { (make) in
            make.top.equalTo(kBackgroundImg.snp.top).offset(25)
            make.left.equalTo(kQrCodeBtn.snp.right).offset(10)
            make.right.equalTo(kmessageBtn.snp.left).offset(-10)
            make.height.equalTo(34)
        }
        
    }
    
    func addAction() {
        kQrCodeBtn.addAction { [weak self](btn) in
            if self?.qrCodeBtnAction != nil {
                self?.qrCodeBtnAction!(btn)
            }
        }
        
        kmessageBtn.addAction { [weak self](btn) in
            if self?.messageBtnAction != nil {
                self?.messageBtnAction!(btn)
            }
        }
        
        kInputView.addAction { [weak self](btn) in
            if self?.searchBtnAction != nil {
                self?.searchBtnAction!(btn)
            }
        }
    }
    
    func updateNavigationBarStatus(alpha:CGFloat) {
        kBackgroundImg.alpha = alpha
    }
    
    func reloadSearchBar() {
        let imageName =  UserInfo.shared.unread_count == "0" ? "new_nav_bell" : "new_nav_bell_message"
        kmessageBtn.setImage(UIImage(named:imageName), for: .normal)
    }
}
