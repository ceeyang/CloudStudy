
//
//  HomeSearchBar.swift
//  CloudStudy
//
//  Created by pro on 2016/10/25.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import SnapKit

class HomeSearchBar: UIView {

    var kBackgroundView : UIView!
    var kInputView      : UIView!
    var kBackgroundImg  : UIImageView!
    var kApparentView   : UIImageView!
    var kmessageBtn     : UIButton!
    var kQrCodeBtn      : UIButton!
    var kSearchBtn      : UIButton!
    
    var qrCodeBtnAction  : buttonActionClosure?
    var messageBtnAction : buttonActionClosure?
    
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
        kQrCodeBtn.addAction { [weak self](btn) in
            if self?.qrCodeBtnAction != nil {
                self?.qrCodeBtnAction!(btn)
            }
        }
        kBackgroundImg.addSubview(kQrCodeBtn)
        kQrCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBackgroundImg.snp.left)
            make.top.equalTo(kBackgroundImg.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        /** 消息按钮 */
        kmessageBtn     = UIButton()
        kmessageBtn.addAction { [weak self](btn) in
            if self?.messageBtnAction != nil {
                self?.messageBtnAction!(btn)
            }
        }
        kBackgroundImg.addSubview(kmessageBtn)
        kmessageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(kBackgroundImg.snp.right)
            make.top.equalTo(kBackgroundImg.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        
    }
    
    func reloadSearchBar() {
        if UserInfo.shared.unread_count != "" {
            kmessageBtn.setImage(UIImage(named:"new_nav_bell_message"), for: .normal)
        } else {
            kmessageBtn.setImage(UIImage(named:"new_nav_bell"), for: .normal)
        }
    }
    
    override func layoutSubviews() {

    }

}
