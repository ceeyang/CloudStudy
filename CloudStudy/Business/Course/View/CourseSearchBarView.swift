//
//  CourseSearchBarView.swift
//  CloudStudy
//
//  Created by pro on 2016/12/1.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit

class CourseSearchBarView: UIView {
    
    public var searchBtnAction  : buttonActionClosure?
    
    public func setSearchBarTitle(_ title:String) {
        kQrCodeBtn.setTitle(title, for: .normal)
    }
    fileprivate var kInputView      : UIImageView!
    fileprivate var kBackgroundImg  : UIImageView!
    
    fileprivate var kQrCodeBtn      : UIButton!
    fileprivate var kSearchBtn      : UIButton!
    
    
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
    fileprivate func setupUI() {
        
        /** 背景图片 */
        kBackgroundImg = UIImageView(image: UIImage(named:"common_actionbar_bg@2x"))
        self.addSubview(kBackgroundImg)
        kBackgroundImg.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        /** 二维码扫描按钮 */
        kQrCodeBtn     = UIButton()
        kQrCodeBtn.isUserInteractionEnabled = false
        kQrCodeBtn.setTitle("Course", for: .normal)
        addSubview(kQrCodeBtn)
        kQrCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBackgroundImg.snp.left)
            make.top.equalTo(kBackgroundImg.snp.top).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 44))
        }
        
        
        /** 搜索框 */
        kInputView = UIImageView(image: UIImage(named: "homepage_black_half_bg"))
        kInputView.isUserInteractionEnabled = true
        kInputView.layer.masksToBounds = true
        kInputView.layer.cornerRadius  = 5
        addSubview(kInputView)
        kInputView.snp.makeConstraints { (make) in
            make.top.equalTo(kBackgroundImg.snp.top).offset(25)
            make.left.equalTo(kQrCodeBtn.snp.right).offset(10)
            make.right.equalTo(kBackgroundImg.snp.right).offset(-10)
            make.height.equalTo(34)
        }
        
        let searchImg = UIImageView(image: UIImage(named: "new_head_search_right"))
        kInputView.addSubview(searchImg)
        searchImg.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(kInputView)
            make.width.equalTo(34)
        }
        
        let label = UILabel()
        label.text = "Search"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        kInputView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(searchImg.snp.right)
            make.right.bottom.top.equalTo(kInputView)
        }
        
        kSearchBtn = UIButton()
        kSearchBtn.layer.masksToBounds = true
        kSearchBtn.layer.cornerRadius  = 5
        kInputView.addSubview(kSearchBtn)
        kSearchBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(kInputView)
        }
        
    }
    
    fileprivate func addAction() {
        
        kSearchBtn.addAction { [weak self](btn) in
            if self?.searchBtnAction != nil {
                self?.searchBtnAction!(btn)
            }
        }
    }
}
