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
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.logData = appDelegate.logData
        
        // 画面の初期化
        self.title = "ログデータ"
        self.view.backgroundColor = UIColor.white
        
        tblView = UITableView(frame: self.view.frame )
        
        // Cell名の登録をおこなう.
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "BeaconLog")
        
        // DataSourceの設定をする.
        tblView.dataSource = self
        
        // Delegateを設定する.
        tblView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(tblView)
        
        
    }
    
    
    // 画面が再表示される時
    override func viewWillAppear( _ animated: Bool ) {
        
        super.viewWillAppear( animated )
        
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( _ animated: Bool ) {
        super.viewDidDisappear( animated )
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    セクションの数を返す.
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logData.arLog.count
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "BeaconLog")
        
        let l : log = self.logData.arLog[indexPath.row] as! log
        
        let major = l.major.intValue
        let minor = l.minor.intValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        
        cell.textLabel?.text = dateFormatter.string(from: l.date as Date)
        cell.detailTextLabel?.text = "major=\(major) minor=\(minor) LatLon=\(l.latitude),\(l.longitude)"
        
        return cell
    }
}


