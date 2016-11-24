//
//  TestViewController.swift
//  QRCode
//
//  Created by pro on 2016/11/24.
//  Copyright © 2016年 gaofu. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0//扫描时长

class ScanCodeViewController: UIViewController {
    
    
    //MARK: -
    //MARK: Global Variables
    
    //@IBOutlet weak var scanPane: UIImageView!///扫描框
    //@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var scanPane: UIImageView!///扫描框
    var activityIndicatorView: UIActivityIndicatorView!
    
    var lightOn = false///开光灯
    
    
    //MARK: -
    //MARK: Lazy Components
    
    lazy var scanLine : UIImageView =
        {
            
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 60, height: 3)
            scanLine.image = UIImage(named: "QRCode_ScanLine")
            
            return scanLine
            
    }()
    
    var scanSession :  AVCaptureSession?
    
    
    //MARK: -
    //MARK: Public Methods
    
    
    //MARK: -
    //MARK: Data Initialize
    
    
    //MARK: -
    //MARK: Life Cycle
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        view.layoutIfNeeded()
        
        title = "扫一扫"
        
        setupUI()
        
        scanPane.addSubview(scanLine)
        
        setupScanSession()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        startScan()
        
    }
    
    func setupUI() {
        
        scanPane = UIImageView(image: UIImage(named: "QRCode_ScanBox"))
        scanPane.alpha = 0.5;
        view.addSubview(scanPane)
        scanPane.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(view)
            make.height.equalTo(200)
            make.width.equalTo(kScreenWidth - 60)
        }
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.backgroundColor = UIColor.red
        scanPane.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(scanPane)
            make.size.equalTo(CGSize(width: 37, height: 37))
        }
        
        let topCoverView = UIView()
        topCoverView.backgroundColor = UIColor.black
        topCoverView.alpha           = 0.3
        view.addSubview(topCoverView)
        topCoverView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(scanPane.snp.top)
        }
        
        let topCoverLabel = UILabel()
        topCoverLabel.text = "Take The QR code / bar code into the box,It will antomatically to scan"
        topCoverLabel.numberOfLines = 2
        topCoverLabel.textColor = UIColor.white
        topCoverLabel.font = UIFont.systemFont(ofSize: 12)
        topCoverView.addSubview(topCoverLabel)
        topCoverLabel.snp.makeConstraints { (make) in
            make.centerX.bottom.equalTo(topCoverView)
            make.width.equalTo(scanPane.snp.width)
            make.height.greaterThanOrEqualTo(40)
        }
        
        let leftCoverView = UIView()
        leftCoverView.backgroundColor = UIColor.black
        leftCoverView.alpha           = 0.3
        view.addSubview(leftCoverView)
        leftCoverView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(scanPane.snp.left)
            make.top.bottom.equalTo(scanPane)
        }
        
        let rightCoverView = UIView()
        rightCoverView.backgroundColor = UIColor.black
        rightCoverView.alpha           = 0.3
        view.addSubview(rightCoverView)
        rightCoverView.snp.makeConstraints { (make) in
            make.left.equalTo(scanPane.snp.right)
            make.right.equalTo(view.snp.right)
            make.top.bottom.equalTo(scanPane)
        }
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.alpha = 0.8
        bottomView.backgroundColor = UIColor.black
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(80)
        }
        
        let bottomCoverView = UIView()
        bottomCoverView.backgroundColor = UIColor.black
        bottomCoverView.alpha           = 0.3
        view.addSubview(bottomCoverView)
        bottomCoverView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scanPane.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        let bottomBtnNormalImageArr  = ["qrcode_scan_btn_photo_nor","qrcode_scan_btn_flash_nor","qrcode_scan_btn_myqrcode_nor"]
        let bottomBtnHightedImageArr = ["qrcode_scan_btn_photo_down","qrcode_scan_btn_flash_down","qrcode_scan_btn_myqrcode_down"]
        var index   = 0
        for imageName in bottomBtnNormalImageArr {
            let btn = UIButton()
            btn.tag = index
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.setImage(UIImage(named:bottomBtnHightedImageArr[index]),for: .highlighted)
            btn.addTarget(self, action: #selector(bottomBtnActionWith(_:)), for: .touchUpInside)
            bottomView.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(bottomView)
                make.width.equalTo(kScreenWidth/3)
                if index == 0 {
                    make.left.equalTo(bottomView.snp.left)
                } else if index == 1 {
                    make.centerX.equalTo(bottomView.snp.centerX)
                } else {
                    make.right.equalTo(bottomView.snp.right)
                }
            })
            index += 1
        }
    }
    
    func bottomBtnActionWith(_ sender:UIButton) {
        if sender.tag == 0 {
            photo()
        } else if sender.tag == 1 {
            light(sender)
        } else {
            print("\(sender)")
        }
    }
    
    
    //MARK: -
    //MARK: Interface Components
    
    func setupScanSession()
    {
        
        do
        {
            //设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            //设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            //设置会话
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input)
            {
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output)
            {
                scanSession.addOutput(output)
            }
            
            //设置扫描类型(二维码和条形码)
            output.metadataObjectTypes = [
                AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeCode39Code,
                AVMetadataObjectTypeCode128Code,
                AVMetadataObjectTypeCode39Mod43Code,
                AVMetadataObjectTypeEAN13Code,
                AVMetadataObjectTypeEAN8Code,
                AVMetadataObjectTypeCode93Code]
            
            //预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
            //设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: self.scanPane.frame))!
            })
            
            
            
            //保存会话
            self.scanSession = scanSession
            
        }
        catch
        {
            //摄像头不可用
            
            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
            
            return
        }
        
    }
    
    //MARK: -
    //MARK: Target Action
    
    //闪光灯
    func light(_ sender: UIButton)
    {
        
        lightOn = !lightOn
        sender.isSelected = lightOn
        if lightOn {
            sender.setImage(UIImage(named:"qrcode_scan_btn_scan_off"), for: .normal)
        } else {
            sender.setImage(UIImage(named:"qrcode_scan_btn_flash_nor"), for: .normal)
        }
        turnTorchOn()
        
    }
    
    //相册
    func photo()
    {
        
        Tool.shareTool.choosePicture(self, editor: true, options: .photoLibrary) {[weak self] (image) in
            
            self!.activityIndicatorView.startAnimating()
            
            DispatchQueue.global().async {
                let recognizeResult = image.recognizeQRCode()
                let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
                DispatchQueue.main.async {
                    self!.activityIndicatorView.stopAnimating()
                    Tool.confirm(title: "扫描结果", message: result, controller: self!)
                }
            }
        }
        
    }
    
    //MARK: -
    //MARK: Data Request
    
    
    //MARK: -
    //MARK: Private Methods
    
    //开始扫描
    fileprivate func startScan()
    {
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
        
        
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation
    {
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    
    ///闪光灯
    private func turnTorchOn()
    {
        
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
        {
            
            if lightOn
            {
                
                Tool.confirm(title: "温馨提示", message: "闪光灯不可用", controller: self)
                
            }
            
            return
        }
        
        if device.hasTorch
        {
            do
            {
                try device.lockForConfiguration()
                
                if lightOn && device.torchMode == .off
                {
                    device.torchMode = .on
                }
                
                if !lightOn && device.torchMode == .on
                {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            }
            catch{ }
            
        }
        
    }
    
    //MARK: -
    //MARK: Dealloc
    
    deinit
    {
        ///移除通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
}


//MARK: -
//MARK: AVCaptureMetadataOutputObjects Delegate

//扫描捕捉完成
extension ScanCodeViewController : AVCaptureMetadataOutputObjectsDelegate
{
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        
        //停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //播放声音
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        //扫完完成
        if metadataObjects.count > 0
        {
            
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                
                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self,handler: { (_) in
                    //继续扫描
                    self.startScan()
                })
                
            }
            
        }
        
    }
    
}
