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
    
    var uuid : NSUUID!
    var major : NSNumber = -1
    var minor : NSNumber = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid!
        self.major = appDelegate.scan_major
        self.minor = appDelegate.scan_minor

        self.uuid = NSUUID(UUIDString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
        self.major = -1
        self.minor = -1

        // Controllerのタイトルを設定する.
        self.title = "ビーコン距離測定（説明)"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        self.imgExec = UIImage(named: "btn_execute.png")
        
        var offset : CGFloat = 0.0

        self.lblDesc1 = UILabel()
        self.lblDesc1.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc1.text = "ビーコン距離測定を行います。ビーコン領域内のビーコンとの距離が一覧表示されます。"
        self.lblDesc1.textAlignment = NSTextAlignment.Left
        self.lblDesc1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc1.numberOfLines = 0
        self.lblDesc1.sizeToFit()
        self.scrView.addSubview(self.lblDesc1)
        
        offset += self.lblDesc1.frame.size.height + 15.0
        
        self.lblDesc2 = UILabel()
        self.lblDesc2.frame = CGRectMake(20.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc2.text = "観測対象のビーコン領域"
        self.lblDesc2.textAlignment = NSTextAlignment.Left
        self.lblDesc2.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc2.numberOfLines = 0
        self.lblDesc2.sizeToFit()
        self.scrView.addSubview(self.lblDesc2)
        
        offset += self.lblDesc2.frame.size.height
        
        self.lblUUID = UILabel()
        self.lblUUID.frame = CGRectMake(20.0, offset, self.view.frame.width - 30.0, 20.0 )
        self.lblUUID.text = "UUID=\(self.uuid.UUIDString)"
        self.lblUUID.textAlignment = NSTextAlignment.Left
        self.lblUUID.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblUUID.font = UIFont.systemFontOfSize(14)
        self.lblUUID.numberOfLines = 0
        self.lblUUID.sizeToFit()
        self.scrView.addSubview(self.lblUUID)
        
        offset += self.lblUUID.frame.size.height
        
        
        self.lblMajor = UILabel()
        self.lblMajor.frame = CGRectMake(20.0, offset, self.view.frame.width - 20.0, 20.0 )
        if( self.major == -1 ) {
            self.lblMajor.text = "Major=未指定"
        } else {
            self.lblMajor.text = "Major=\(self.major)"
        }
        
        self.lblMajor.textAlignment = NSTextAlignment.Left
        self.lblMajor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMajor.numberOfLines = 0
        self.lblMajor.sizeToFit()
        self.scrView.addSubview(self.lblMajor)
        
        offset += self.lblMajor.frame.size.height
        
        self.lblMinor = UILabel()
        self.lblMinor.frame = CGRectMake(20.0, offset, self.view.frame.width - 20.0, 20.0 )
        if( self.minor == -1 ) {
            self.lblMinor.text = "Minor=未指定"
        } else {
            self.lblMinor.text = "Minor=\(self.minor)"
        }
        
        self.lblMinor.textAlignment = NSTextAlignment.Left
        self.lblMinor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMinor.numberOfLines = 0
        self.lblMinor.sizeToFit()
        self.scrView.addSubview(self.lblMinor)
        
        offset += self.lblMinor.frame.size.height + 15.0
        
        self.lblDesc3 = UILabel()
        self.lblDesc3.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc3.text = "観測対象のビーコン領域は「設定」画面で変更できます。"
        self.lblDesc3.textAlignment = NSTextAlignment.Left
        self.lblDesc3.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc3.numberOfLines = 0
        self.lblDesc3.sizeToFit()
        self.scrView.addSubview(self.lblDesc3)
        
        offset += self.lblDesc3.frame.size.height + 15.0


        let btnX = (self.view.frame.width - self.imgExec.size.width) / 2
        
        self.btnExec = UIButton(frame: CGRectMake(btnX,offset,self.imgExec.size.width,self.imgExec.size.height))
        self.btnExec.setImage(self.imgExec, forState: UIControlState.Normal)
        self.btnExec.tag = 1
        self.btnExec.addTarget(self, action: #selector(Recv2DescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnExec)
        
        if( offset > self.view.frame.height ) {
            scrView.contentSize = CGSizeMake(self.view.frame.width, offset + (self.view.frame.height / 2) )
        }
    }
    
    override func viewWillAppear( animated: Bool ) {
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Recv2DescViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    func onOrientationChange(notification: NSNotification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    ボタンイベント
    */
    internal func onClickButton(sender: UIButton){
        
        if( sender.tag == 1 ) {
            // 移動先のViewを定義する.
            let vc = Recv2ViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

    
}

