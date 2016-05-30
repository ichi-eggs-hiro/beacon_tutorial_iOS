//
//  HomeViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var imgViewLogo : UIImageView!

    var btnSetting : UIButton!
    var btnSend : UIButton!
    var btnRecv1 : UIButton!
    var btnRecv2 : UIButton!
    var btnRecv3 : UIButton!
    var btnCheckLog : UIButton!
    var btnAbout : UIButton!
    
    var imgLogo : UIImage!
    var imgBtnSetting : UIImage!
    var imgBtnSend : UIImage!
    var imgBtnRecv1 : UIImage!
    var imgBtnRecv2 : UIImage!
    var imgBtnRecv3 : UIImage!
    var imgBtnCheckLog : UIImage!
    var imgBtnAbout : UIImage!
    
    var scrView : UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する.
        self.title = "Beacon入門"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        

        self.imgLogo = UIImage(named: "logo.png")
        self.imgBtnSetting = UIImage(named: "btn_setting.png")
        self.imgBtnSend = UIImage(named: "btn_send.png")
        self.imgBtnRecv1 = UIImage(named: "btn_receive1.png")
        self.imgBtnRecv2 = UIImage(named: "btn_receive2.png")
        self.imgBtnRecv3 = UIImage(named: "btn_receive3.png")
        self.imgBtnCheckLog = UIImage(named: "btn_log.png")
        self.imgBtnAbout = UIImage(named: "btn_about.png")
        
        // ステータスバーの高さを取得
//        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        // ナビゲーションバーの高さを取得
//        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        var offset : CGFloat = 0.0
        let logoX = (self.view.frame.width - self.imgLogo.size.width) / 2

        self.imgViewLogo = UIImageView(frame: CGRectMake(logoX, offset, self.imgLogo.size.width, self.imgLogo.size.height))
        self.imgViewLogo.image = self.imgLogo
        self.imgViewLogo.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)

        self.scrView.addSubview(self.imgViewLogo)

        offset += self.imgLogo.size.height + 10.0
        let btnX = (self.view.frame.width - self.imgBtnSetting.size.width) / 2
        
        self.btnSetting = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnSetting.size.width,self.imgBtnSetting.size.height))
        self.btnSetting.setImage(self.imgBtnSetting, forState: UIControlState.Normal)
        self.btnSetting.tag = 1
        self.btnSetting.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnSetting)

        offset += self.imgBtnSetting.size.height + 10.0
        
        self.btnRecv1 = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnRecv1.size.width,self.imgBtnRecv1.size.height))
        self.btnRecv1.setImage(self.imgBtnRecv1, forState: UIControlState.Normal)
        self.btnRecv1.tag = 3
        self.btnRecv1.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnRecv1)

        offset += self.imgBtnRecv1.size.height + 10.0
        
        self.btnRecv2 = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnRecv2.size.width,self.imgBtnRecv2.size.height))
        self.btnRecv2.setImage(self.imgBtnRecv2, forState: UIControlState.Normal)
        self.btnRecv2.tag = 4
        self.btnRecv2.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnRecv2)

        offset += self.imgBtnRecv2.size.height + 10.0
        
        self.btnRecv3 = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnRecv3.size.width,self.imgBtnRecv3.size.height))
        self.btnRecv3.setImage(self.imgBtnRecv3, forState: UIControlState.Normal)
        self.btnRecv3.tag = 5
        self.btnRecv3.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnRecv3)
        
        offset += self.imgBtnRecv3.size.height + 10.0
        
        self.btnCheckLog = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnCheckLog.size.width,self.imgBtnCheckLog.size.height))
        self.btnCheckLog.setImage(self.imgBtnCheckLog, forState: UIControlState.Normal)
        self.btnCheckLog.tag = 6
        self.btnCheckLog.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnCheckLog)
        
        offset += self.imgBtnCheckLog.size.height + 10.0
        
        self.btnSend = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnSend.size.width,self.imgBtnSend.size.height))
        self.btnSend.setImage(self.imgBtnSend, forState: UIControlState.Normal)
        self.btnSend.tag = 2
        self.btnSend.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnSend)
        
        offset += self.imgBtnSend.size.height + 10.0

        
        self.btnAbout = UIButton(frame: CGRectMake(btnX,offset,self.imgBtnAbout.size.width,self.imgBtnAbout.size.height))
        self.btnAbout.setImage(self.imgBtnAbout, forState: UIControlState.Normal)
        self.btnAbout.tag = 7
        self.btnAbout.addTarget(self, action: #selector(HomeViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnAbout)

        offset += self.imgBtnAbout.size.height + 10.0

        self.scrView.contentSize = CGSizeMake(self.view.frame.width, offset )
    }
    
    override func viewWillAppear( animated: Bool ) {
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
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
            let vc = SettingDescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 2 ) {
            // 移動先のViewを定義する.
            let vc = SendDescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 3 ) {
            // 移動先のViewを定義する.
            let vc = Recv1DescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 4 ) {
            // 移動先のViewを定義する.
            let vc = Recv2DescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 5 ) {
            // 移動先のViewを定義する.
            let vc = Recv3DescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 6 ) {
            // 移動先のViewを定義する.
            let vc = CheckLogDescViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 7 ) {
            // 移動先のViewを定義する.
            let vc = AboutAppsViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}
