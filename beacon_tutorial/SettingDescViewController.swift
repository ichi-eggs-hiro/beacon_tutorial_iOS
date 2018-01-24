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
    
    var scan_uuid:UUID!
    var scan_major:NSNumber!
    var scan_minor:NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.scan_uuid = appDelegate.scan_uuid as UUID!
        self.scan_major = appDelegate.scan_major
        self.scan_minor = appDelegate.scan_minor

        
        // Controllerのタイトルを設定する.
        self.title = "設定（説明）"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        
        let lblDesc1:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc1.text = "監視対象のUUID,Major,Minorを変更できます。"
        lblDesc1.textAlignment = NSTextAlignment.left
        lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 15.0

        let lblDesc2:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc2.text = "UUID"
        lblDesc2.textAlignment = NSTextAlignment.left
        lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height+5.0

        lblFullUUID = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblFullUUID.text = self.scan_uuid.uuidString
        lblFullUUID.font = UIFont.systemFont(ofSize: 14)
        lblFullUUID.textAlignment = NSTextAlignment.left
        lblFullUUID.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblFullUUID.numberOfLines = 0
        lblFullUUID.sizeToFit()
        scrView.addSubview(lblFullUUID)
        offset += lblFullUUID.frame.size.height + 15.0

        
        btnChangeUUID = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnChangeUUID.setTitle("変更", for: UIControlState())
        btnChangeUUID.backgroundColor = UIColor.gray
        btnChangeUUID.layer.masksToBounds = true
        btnChangeUUID.tag = 1
        btnChangeUUID.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnChangeUUID)
        
        offset += btnChangeUUID.frame.size.height + 15.0

        
        let lblDesc3:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc3.text = "Major"
        lblDesc3.textAlignment = NSTextAlignment.left
        lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        scrView.addSubview(lblDesc3)
        offset += lblDesc3.frame.size.height + 5.0
        
        lblMajor = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        if( self.scan_major == -1 ) {
            lblMajor.text = "未指定"
            
        } else {
            lblMajor.text = "\(self.scan_major)"
            
        }
        lblMajor.textAlignment = NSTextAlignment.left
        lblMajor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblMajor)
        offset += lblMajor.frame.size.height + 15.0
        
        btnChangeMajor = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnChangeMajor.setTitle("変更", for: UIControlState())
        btnChangeMajor.backgroundColor = UIColor.gray
        btnChangeMajor.layer.masksToBounds = true
        btnChangeMajor.tag = 2
        btnChangeMajor.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnChangeMajor)
        
        offset += btnChangeMajor.frame.size.height + 15.0
        
        let lblDesc4:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc4.text = "Minor"
        lblDesc4.textAlignment = NSTextAlignment.left
        lblDesc4.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc4.numberOfLines = 0
        lblDesc4.sizeToFit()
        scrView.addSubview(lblDesc4)
        offset += lblDesc4.frame.size.height + 5.0
        
        lblMinor = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        if( self.scan_minor == -1 ) {
            lblMinor.text = "未指定"
            
        } else {
            lblMinor.text = "\(self.scan_minor)"
            
        }
        lblMinor.textAlignment = NSTextAlignment.left
        lblMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblMinor)
        offset += lblMinor.frame.size.height + 15.0

        btnChangeMinor = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnChangeMinor.setTitle("変更", for: UIControlState())
        btnChangeMinor.backgroundColor = UIColor.gray
        btnChangeMinor.layer.masksToBounds = true
        btnChangeMinor.tag = 3
        btnChangeMinor.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnChangeMinor)
        
        offset += btnChangeMinor.frame.size.height + 15.0
        
        let lblDesc5:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc5.text = "「初期値に戻す」をタップすると、上記設定を初期値（デフォルト値）に戻せます。"
        lblDesc5.textAlignment = NSTextAlignment.left
        lblDesc5.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc5.numberOfLines = 0
        lblDesc5.sizeToFit()
        scrView.addSubview(lblDesc5)
        offset += lblDesc5.frame.size.height + 5.0
        
        btnReset = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnReset.setTitle("初期値に戻す", for: UIControlState())
        btnReset.backgroundColor = UIColor.gray
        btnReset.layer.masksToBounds = true
        btnReset.tag = 4
        btnReset.addTarget(self, action: #selector(SettingDescViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnReset)
        
        offset += btnReset.frame.size.height + 15.0
        
        scrView.contentSize = CGSize(width: self.view.frame.width, height: offset )
        
    }
    
    override func viewWillAppear( _ animated: Bool ) {
        self.scan_uuid = appDelegate.scan_uuid as UUID!
        self.scan_major = appDelegate.scan_major
        self.scan_minor = appDelegate.scan_minor

        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(SettingDescViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    @objc func onOrientationChange(_ notification: Notification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        lblFullUUID.text = self.scan_uuid.uuidString
        
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
    @objc internal func onClickButton(_ sender: UIButton){
        
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
            
            self.scan_uuid = appDelegate.scan_uuid as UUID!
            self.scan_major = appDelegate.scan_major
            self.scan_minor = appDelegate.scan_minor

            refresh()
            
            showAlert("初期値に戻しました。")
            
        }

    }
    
    func showAlert( _ msg:String ) {
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: msg, preferredStyle: .alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
        }
        
        // OKのActionを追加する.
        myAlert.addAction(myOkAction)
        
        // UIAlertを発動する.
        present(myAlert, animated: true, completion: nil)

    }
}
