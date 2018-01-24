//
//  Recv2DescViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit

class Recv2DescViewController: UIViewController {
    
    var scrView:UIScrollView!

    
    var btnExec : UIButton!
    var imgExec : UIImage!
    
    var lblDesc1 : UILabel!
    var lblDesc2 : UILabel!
    var lblUUID : UILabel!
    var lblMajor : UILabel!
    var lblMinor : UILabel!
    var lblDesc3 : UILabel!
    
    var uuid : UUID!
    var major : NSNumber = -1
    var minor : NSNumber = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid! as UUID!
        self.major = appDelegate.scan_major
        self.minor = appDelegate.scan_minor

        // Controllerのタイトルを設定する.
        self.title = "ビーコン距離測定（説明)"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        self.imgExec = UIImage(named: "btn_execute.png")
        
        var offset : CGFloat = 0.0

        self.lblDesc1 = UILabel()
        self.lblDesc1.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc1.text = "ビーコン距離測定を行います。ビーコン領域内のビーコンとの距離が一覧表示されます。"
        self.lblDesc1.textAlignment = NSTextAlignment.left
        self.lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc1.numberOfLines = 0
        self.lblDesc1.sizeToFit()
        self.scrView.addSubview(self.lblDesc1)
        
        offset += self.lblDesc1.frame.size.height + 15.0
        
        self.lblDesc2 = UILabel()
        self.lblDesc2.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc2.text = "観測対象のビーコン領域"
        self.lblDesc2.textAlignment = NSTextAlignment.left
        self.lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc2.numberOfLines = 0
        self.lblDesc2.sizeToFit()
        self.scrView.addSubview(self.lblDesc2)
        
        offset += self.lblDesc2.frame.size.height
        
        self.lblUUID = UILabel()
        self.lblUUID.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 30.0, height: 20.0 )
        self.lblUUID.text = "UUID=\(self.uuid.uuidString)"
        self.lblUUID.textAlignment = NSTextAlignment.left
        self.lblUUID.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblUUID.font = UIFont.systemFont(ofSize: 14)
        self.lblUUID.numberOfLines = 0
        self.lblUUID.sizeToFit()
        self.scrView.addSubview(self.lblUUID)
        
        offset += self.lblUUID.frame.size.height
        
        
        self.lblMajor = UILabel()
        self.lblMajor.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        if( self.major == -1 ) {
            self.lblMajor.text = "Major=未指定"
        } else {
            self.lblMajor.text = "Major=\(self.major)"
        }
        
        self.lblMajor.textAlignment = NSTextAlignment.left
        self.lblMajor.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblMajor.numberOfLines = 0
        self.lblMajor.sizeToFit()
        self.scrView.addSubview(self.lblMajor)
        
        offset += self.lblMajor.frame.size.height
        
        self.lblMinor = UILabel()
        self.lblMinor.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        if( self.minor == -1 ) {
            self.lblMinor.text = "Minor=未指定"
        } else {
            self.lblMinor.text = "Minor=\(self.minor)"
        }
        
        self.lblMinor.textAlignment = NSTextAlignment.left
        self.lblMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblMinor.numberOfLines = 0
        self.lblMinor.sizeToFit()
        self.scrView.addSubview(self.lblMinor)
        
        offset += self.lblMinor.frame.size.height + 15.0
        
        self.lblDesc3 = UILabel()
        self.lblDesc3.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc3.text = "観測対象のビーコン領域は「設定」画面で変更できます。"
        self.lblDesc3.textAlignment = NSTextAlignment.left
        self.lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc3.numberOfLines = 0
        self.lblDesc3.sizeToFit()
        self.scrView.addSubview(self.lblDesc3)
        
        offset += self.lblDesc3.frame.size.height + 15.0


        let btnX = (self.view.frame.width - self.imgExec.size.width) / 2
        
        self.btnExec = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgExec.size.width,height: self.imgExec.size.height))
        self.btnExec.setImage(self.imgExec, for: UIControlState())
        self.btnExec.tag = 1
        self.btnExec.addTarget(self, action: #selector(Recv2DescViewController.onClickButton(_:)), for: .touchUpInside)
        self.scrView.addSubview(self.btnExec)
        
        if( offset > self.view.frame.height ) {
            scrView.contentSize = CGSize(width: self.view.frame.width, height: offset + (self.view.frame.height / 2) )
        }
    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(Recv2DescViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    @objc func onOrientationChange(_ notification: Notification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    ボタンイベント
    */
    @objc internal func onClickButton(_ sender: UIButton){
        
        if( sender.tag == 1 ) {
            // 移動先のViewを定義する.
            let vc = Recv2ViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

    
}

