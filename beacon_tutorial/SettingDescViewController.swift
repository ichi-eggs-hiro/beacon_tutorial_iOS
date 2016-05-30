//
//  SettingDescViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit

class SettingDescViewController: UIViewController {
    
    var appDelegate:AppDelegate!
    
    var lblFullUUID:UILabel!
    var lblMajor:UILabel!
    var lblMinor:UILabel!
    
    var btnChangeUUID:UIButton!
    var btnChangeMajor:UIButton!
    var btnChangeMinor:UIButton!
    var btnReset:UIButton!
    
    var scrView:UIScrollView!
    
    var scan_uuid:NSUUID!
    var scan_major:NSNumber!
    var scan_minor:NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.scan_uuid = appDelegate.scan_uuid
        self.scan_major = appDelegate.scan_major
        self.scan_minor = appDelegate.scan_minor

        
        // Controllerのタイトルを設定する.
        self.title = "設定（説明）"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        
        let lblDesc1:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc1.text = "監視対象のUUID,Major,Minorを変更できます。"
        lblDesc1.textAlignment = NSTextAlignment.Left
        lblDesc1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 15.0

        let lblDesc2:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc2.text = "UUID"
        lblDesc2.textAlignment = NSTextAlignment.Left
        lblDesc2.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height+5.0

        lblFullUUID = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblFullUUID.text = self.scan_uuid.UUIDString
        lblFullUUID.font = UIFont.systemFontOfSize(14)
        lblFullUUID.textAlignment = NSTextAlignment.Left
        lblFullUUID.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblFullUUID.numberOfLines = 0
        lblFullUUID.sizeToFit()
        scrView.addSubview(lblFullUUID)
        offset += lblFullUUID.frame.size.height + 15.0

        
        btnChangeUUID = UIButton(frame: CGRectMake(20,offset,self.view.frame.size.width - 40,25.0))
        btnChangeUUID.setTitle("変更", forState: .Normal)
        btnChangeUUID.backgroundColor = UIColor.grayColor()
        btnChangeUUID.layer.masksToBounds = true
        btnChangeUUID.tag = 1
        btnChangeUUID.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        scrView.addSubview(self.btnChangeUUID)
        
        offset += btnChangeUUID.frame.size.height + 15.0

        
        let lblDesc3:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc3.text = "Major"
        lblDesc3.textAlignment = NSTextAlignment.Left
        lblDesc3.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        scrView.addSubview(lblDesc3)
        offset += lblDesc3.frame.size.height + 5.0
        
        lblMajor = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        if( self.scan_major == -1 ) {
            lblMajor.text = "未指定"
            
        } else {
            lblMajor.text = "\(self.scan_major)"
            
        }
        lblMajor.textAlignment = NSTextAlignment.Left
        lblMajor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        scrView.addSubview(lblMajor)
        offset += lblMajor.frame.size.height + 15.0
        
        btnChangeMajor = UIButton(frame: CGRectMake(20,offset,self.view.frame.size.width - 40,25.0))
        btnChangeMajor.setTitle("変更", forState: .Normal)
        btnChangeMajor.backgroundColor = UIColor.grayColor()
        btnChangeMajor.layer.masksToBounds = true
        btnChangeMajor.tag = 2
        btnChangeMajor.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        scrView.addSubview(self.btnChangeMajor)
        
        offset += btnChangeMajor.frame.size.height + 15.0
        
        let lblDesc4:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc4.text = "Minor"
        lblDesc4.textAlignment = NSTextAlignment.Left
        lblDesc4.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc4.numberOfLines = 0
        lblDesc4.sizeToFit()
        scrView.addSubview(lblDesc4)
        offset += lblDesc4.frame.size.height + 5.0
        
        lblMinor = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        if( self.scan_minor == -1 ) {
            lblMinor.text = "未指定"
            
        } else {
            lblMinor.text = "\(self.scan_minor)"
            
        }
        lblMinor.textAlignment = NSTextAlignment.Left
        lblMinor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        scrView.addSubview(lblMinor)
        offset += lblMinor.frame.size.height + 15.0

        btnChangeMinor = UIButton(frame: CGRectMake(20,offset,self.view.frame.size.width - 40,25.0))
        btnChangeMinor.setTitle("変更", forState: .Normal)
        btnChangeMinor.backgroundColor = UIColor.grayColor()
        btnChangeMinor.layer.masksToBounds = true
        btnChangeMinor.tag = 3
        btnChangeMinor.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        scrView.addSubview(self.btnChangeMinor)
        
        offset += btnChangeMinor.frame.size.height + 15.0
        
        let lblDesc5:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc5.text = "「初期値に戻す」をタップすると、上記設定を初期値（デフォルト値）に戻せます。"
        lblDesc5.textAlignment = NSTextAlignment.Left
        lblDesc5.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc5.numberOfLines = 0
        lblDesc5.sizeToFit()
        scrView.addSubview(lblDesc5)
        offset += lblDesc5.frame.size.height + 5.0
        
        btnReset = UIButton(frame: CGRectMake(20,offset,self.view.frame.size.width - 40,25.0))
        btnReset.setTitle("初期値に戻す", forState: .Normal)
        btnReset.backgroundColor = UIColor.grayColor()
        btnReset.layer.masksToBounds = true
        btnReset.tag = 4
        btnReset.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        scrView.addSubview(self.btnReset)
        
        offset += btnReset.frame.size.height + 15.0
        
        scrView.contentSize = CGSizeMake(self.view.frame.width, offset )
        
    }
    
    override func viewWillAppear( animated: Bool ) {
        self.scan_uuid = appDelegate.scan_uuid
        self.scan_major = appDelegate.scan_major
        self.scan_minor = appDelegate.scan_minor

        refresh()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingDescViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    func onOrientationChange(notification: NSNotification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        lblFullUUID.text = self.scan_uuid.UUIDString
        
        if( self.scan_major == -1 ) {
            lblMajor.text = "未指定"
            
        } else {
            lblMajor.text = "\(self.scan_major)"
            
        }
        
        if( self.scan_minor == -1 ) {
            lblMinor.text = "未指定"
            
        } else {
            lblMinor.text = "\(self.scan_minor)"
            
        }


    }
    
    /*
    ボタンイベント
    */
    internal func onClickButton(sender: UIButton){
        
        if( sender.tag == 1 ) {
            // 移動先のViewを定義する.
            let vc = InputUUIDViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 2 ) {
            // 移動先のViewを定義する.
            let vc = InputMajorViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 3 ) {
            // 移動先のViewを定義する.
            let vc = InputMinorViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 4 ) {
            
            appDelegate.scan_uuid = appDelegate.defaultUUID
            appDelegate.scan_major = -1
            appDelegate.scan_minor = -1
            
            appDelegate.Save()
            
            self.scan_uuid = appDelegate.scan_uuid
            self.scan_major = appDelegate.scan_major
            self.scan_minor = appDelegate.scan_minor

            refresh()
            
            showAlert("初期値に戻しました。")
            
        }

    }
    
    func showAlert( msg:String ) {
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: msg, preferredStyle: .Alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
            print("Action OK!!")
        }
        
        // OKのActionを追加する.
        myAlert.addAction(myOkAction)
        
        // UIAlertを発動する.
        presentViewController(myAlert, animated: true, completion: nil)

    }
}
