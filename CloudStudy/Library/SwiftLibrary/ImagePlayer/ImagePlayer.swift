//
//  ImagePlayer.swift
//  CloudStudy
//
//  Created by pro on 2016/10/31.
//  Copyright © 2016年 daisy. All rights reserved.
//

import UIKit
import Kingfisher

class ImagePlayer: UIView,UIScrollViewDelegate {

    var imageArr:Array<String> = []
    var autoPlay:Bool          = true
    var autoPlayTime:Float     = 2.0
    var currentIndex:Int       = 0
    var imageDidSelectedAction : ImageDidSelectedClosure?
    var defaultImageName       = "banner_bg_1"
    var defaultImage           = UIImageView()
    
    private var timer:Timer!
    private var scrollview : UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        scrollview = UIScrollView(frame:self.frame)
        scrollview.isPagingEnabled = true
        scrollview.delegate = self
        scrollview.showsHorizontalScrollIndicator = false
        addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        defaultImage = UIImageView(image: UIImage(named: defaultImageName))
        scrollview.addSubview(defaultImage)
        defaultImage.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollview)
        }
    }
    
    func reloadData() {
        
        if imageArr.count == 0 {
            return
        }
        
        for view in scrollview.subviews {
            view.removeFromSuperview()
        }
        
        for i in 0..<imageArr.count {
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string:imageArr[i]), placeholder: UIImage(named: defaultImageName), options: nil, progressBlock: nil, completionHandler: nil)
            imageView.isUserInteractionEnabled = true
            imageView.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(tap:)))
            imageView.addGestureRecognizer(tap)
            scrollview.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(scrollview.snp.top)
                make.left.equalTo(scrollview.snp.left).offset(CGFloat(i)*scrollview.frame.size.width)
                make.size.equalTo(scrollview.frame.size)
            })
        }
        scrollview.contentSize = CGSize(width: scrollview.frame.size.width * CGFloat(imageArr.count), height: 0)
        
        if autoPlay {
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoPlayTime), target: self, selector:#selector(autoScroll), userInfo: nil, repeats: true)
            }
        }
    }
    
    func autoScroll() {
        
        if currentIndex < imageArr.count - 1 {
            currentIndex += 1
            scrollview.setContentOffset(CGPoint(x:scrollview.frame.size.width * CGFloat(currentIndex),y:0), animated: true)
        } else {
            currentIndex = 0
            scrollview.setContentOffset(CGPoint(x:scrollview.frame.size.width * CGFloat(currentIndex),y:0), animated: false)
        }
        
    }
    
    
    func tapGestureAction(tap:UIGestureRecognizer) {
        if imageDidSelectedAction != nil {
            imageDidSelectedAction!((tap.view?.tag)!)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoPlay {
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        currentIndex = Int(scrollview.contentOffset.x) / Int(scrollview.frame.size.width)
        
        if currentIndex == 0 {
            scrollview.scrollRectToVisible(CGRect(x: scrollview.frame.size.width * CGFloat(imageArr.count), y: 0, width: scrollview.frame.size.width, height: scrollview.frame.size.height), animated: false)
            currentIndex = imageArr.count - 1
        } else if currentIndex == imageArr.count + 1 {
            scrollView.scrollRectToVisible(CGRect(x:scrollview.frame.size.width,y:0,width: scrollview.frame.size.width, height:scrollview.bounds.size.height), animated:false)
            currentIndex = 0
        } else {
            currentIndex -= 1
        }
        
        if autoPlay {
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoPlayTime), target: self, selector:#selector(autoScroll), userInfo: nil, repeats: true)
            }
        }
    }
}
