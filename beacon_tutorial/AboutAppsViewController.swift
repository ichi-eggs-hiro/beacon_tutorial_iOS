//
//  AboutAppsViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit

class AboutAppsViewController: UIViewController {
    
    var scrView : UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する.
        self.title = "このアプリについて"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset : CGFloat = 0.0

        let lblDesc1 = UILabel()
        lblDesc1.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        lblDesc1.text = "このアプリについて"
        lblDesc1.textAlignment = NSTextAlignment.left
        lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc1.font = UIFont.systemFont(ofSize: 20)
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        self.scrView.addSubview(lblDesc1)
        
        offset += lblDesc1.frame.size.height + 15.0

        let lblDesc2 = UILabel()
        lblDesc2.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20, height: 20.0 )
        lblDesc2.text = "「Beacon入門」アプリは、iBeacon対応アプリの基礎となる「領域観測」「距離の測定」という2つの機能の動作を手軽に体験できるよう開発したアプリです。"
        lblDesc2.textAlignment = NSTextAlignment.left
        lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        self.scrView.addSubview(lblDesc2)
        
        offset += lblDesc2.frame.size.height + 10.0

        let lblDesc3 = UILabel()
        lblDesc3.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20, height: 20.0 )
        lblDesc3.text = "このアプリの利用者として想定しているのは、次のような方々です。"
        lblDesc3.textAlignment = NSTextAlignment.left
        lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        self.scrView.addSubview(lblDesc3)
        
        offset += lblDesc3.frame.size.height + 10.0
        
        let lblDesc4 = UILabel()
        lblDesc4.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 30, height: 20.0 )
        lblDesc4.text = "・iBeaconを活用した事業を検討している方"
        lblDesc4.textAlignment = NSTextAlignment.left
        lblDesc4.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc4.numberOfLines = 0
        lblDesc4.sizeToFit()
        self.scrView.addSubview(lblDesc4)
        
        offset += lblDesc4.frame.size.height + 5.0

        let lblDesc5 = UILabel()
        lblDesc5.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 30, height: 20.0 )
        lblDesc5.text = "・iBeacon対応アプリを開発しようと考えている開発者の方"
        lblDesc5.textAlignment = NSTextAlignment.left
        lblDesc5.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc5.numberOfLines = 0
        lblDesc5.sizeToFit()
        self.scrView.addSubview(lblDesc5)
        
        offset += lblDesc5.frame.size.height + 5.0
        
        let lblDesc6 = UILabel()
        lblDesc6.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 30, height: 20.0 )
        lblDesc6.text = "・iBeaconに興味のある方"
        lblDesc6.textAlignment = NSTextAlignment.left
        lblDesc6.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc6.numberOfLines = 0
        lblDesc6.sizeToFit()
        self.scrView.addSubview(lblDesc6)
        
        offset += lblDesc6.frame.size.height + 15.0
        
        let lblDesc7 = UILabel()
        lblDesc7.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20, height: 20.0 )
        lblDesc7.text = "このアプリを使用すると、iBeacon に端末が近づいた時、どのようなタイミングで検知できるのか、また、検知できなくなるのか。iBeacon の識別や距離測定の精度などを体験を通じて理解できるようになります。"
        lblDesc7.textAlignment = NSTextAlignment.left
        lblDesc7.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc7.numberOfLines = 0
        lblDesc7.sizeToFit()
        self.scrView.addSubview(lblDesc7)
        
        offset += lblDesc7.frame.size.height + 15.0
        
        let lblDesc8 = UILabel()
        lblDesc8.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20, height: 20.0 )
        lblDesc8.text = "このアプリは、書籍「iBeacon＆Eddystone］統計・防災・位置情報がひと目でわかるビーコンアプリの作り方（技術評論社）」の付録的な位置づけでもあります。書籍の中では、iBeacon の基礎知識から、活用するためのヒント、さらには、iOS/Android での実装方法などを説明しています。本アプリのソースコードも一部抜粋して掲載しております。"
        lblDesc8.textAlignment = NSTextAlignment.left
        lblDesc8.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc8.numberOfLines = 0
        lblDesc8.sizeToFit()
        self.scrView.addSubview(lblDesc8)
        
        offset += lblDesc8.frame.size.height + 15.0
        
        let lblDesc9 = UILabel()
        lblDesc9.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        lblDesc9.text = "Beacon入門 Version1.1"
        lblDesc9.textAlignment = NSTextAlignment.left
        lblDesc9.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc9.font = UIFont.systemFont(ofSize: 20)
        lblDesc9.numberOfLines = 0
        lblDesc9.sizeToFit()
        self.scrView.addSubview(lblDesc9)
        
        offset += lblDesc9.frame.size.height + 15.0

        self.scrView.contentSize = CGSize(width: self.view.frame.width, height: offset )

    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(AboutAppsViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    @objc func onOrientationChange(_ notification: Notification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

