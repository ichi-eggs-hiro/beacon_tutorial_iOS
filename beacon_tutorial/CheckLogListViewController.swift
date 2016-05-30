//
//  CheckLogListViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/19.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import UIKit
import CoreLocation


class CheckLogListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tblView : UITableView!
    var logData: Logs!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.logData = appDelegate.logData
        
        // 画面の初期化
        self.title = "ログデータ"
        self.view.backgroundColor = UIColor.whiteColor()
        
        tblView = UITableView(frame: self.view.frame )
        
        // Cell名の登録をおこなう.
        tblView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BeaconLog")
        
        // DataSourceの設定をする.
        tblView.dataSource = self
        
        // Delegateを設定する.
        tblView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(tblView)
        
        
    }
    
    
    // 画面が再表示される時
    override func viewWillAppear( animated: Bool ) {
        
        super.viewWillAppear( animated )
        
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( animated: Bool ) {
        super.viewDidDisappear( animated )
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    セクションの数を返す.
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logData.arLog.count
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "BeaconLog")
        
        let l : log = self.logData.arLog[indexPath.row] as! log
        
        let major = l.major.integerValue
        let minor = l.minor.integerValue
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        
        cell.textLabel?.text = dateFormatter.stringFromDate(l.date)
        cell.detailTextLabel?.text = "major=\(major) minor=\(minor) LatLon=\(l.latitude),\(l.longitude)"
        
        return cell
    }
}


