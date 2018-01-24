//
//  Recv2ViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/09.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import CoreLocation


class Recv2ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var tblView : UITableView!
    
    // CoreLocation
    var locationManager:CLLocationManager!
    var beaconRegion:CLBeaconRegion!
    var uuid : UUID!
    var major :NSNumber = -1
    var minor :NSNumber = -1
    
    var isBeaconRanging : Bool = false
    
    // 受信したBeaconのリスト
    var beaconLists : NSMutableArray!
    
    var location : String = ""
    var msgStatus : String = ""
    var msgInOut : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid! as UUID!
        self.major = appDelegate.scan_major
        self.minor = appDelegate.scan_minor
        
        
        
        // ロケーションマネージャの作成.
        locationManager = CLLocationManager()
        locationManager.delegate = self         // デリゲートを自身に設定.
        
        // ビーコン領域の識別子を設定.
        let identifierStr:NSString = "BeaconTutorial"
        
        
        // ビーコン領域の初期化
        self.beaconRegion = CLBeaconRegion(proximityUUID:uuid, identifier:identifierStr as String)
        
        if( self.major != -1 && self.minor == -1 ) {
            let majorVal:UInt16 = numericCast(self.major.intValue)
            self.beaconRegion = CLBeaconRegion(proximityUUID:uuid, major: majorVal, identifier: identifierStr as String)
        }
        
        if( self.major != -1 && self.minor != -1 ) {
            let majorVal:UInt16 = numericCast(self.major.intValue)
            let minorVal:UInt16 = numericCast(self.major.intValue)
            self.beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: majorVal, minor: minorVal, identifier: identifierStr as String)
        }
        
        // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
        self.beaconRegion.notifyEntryStateOnDisplay = false
        
        // 入域通知の設定.
        self.beaconRegion.notifyOnEntry = true
        
        // 退域通知の設定.
        self.beaconRegion.notifyOnExit = true
        
        // 配列をリセット
        self.beaconLists = NSMutableArray()
        
        
        // iOS8 以降の　使用許可取得処理
        if( UIDevice.current.systemVersion.hasPrefix("8") ) {
            
            // セキュリティ認証のステータスを取得
            let status = CLLocationManager.authorizationStatus()
            
            // まだ認証が得られていない場合は、認証ダイアログを表示
            if(status == CLAuthorizationStatus.notDetermined) {
                
                self.locationManager.requestAlwaysAuthorization()
                
            }
        }
        
        
        
        // 現在地の取得のための設定
        // 取得精度の設定.
        // locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        // locationManager.distanceFilter = 100
        
        // 位置情報の取得開始
        // locationManager.startUpdatingLocation()
        
        
        
        
        // 画面の初期化
        self.title = "ビーコン距離測定"
        self.view.backgroundColor = UIColor.white
        
        //        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        //        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        //        var offset = statusBarHeight + CGFloat( navBarHeight! )
        
        tblView = UITableView(frame: self.view.frame )
        
        // Cell名の登録をおこなう.
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
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
        
        if( self.isBeaconRanging == false ) {
            // Beacon の監視を再開する。
            self.locationManager.startRangingBeacons(in: self.beaconRegion);
            self.isBeaconRanging = true;
            print("restart monitoring Beacons")
        }
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( _ animated: Bool ) {
        super.viewDidDisappear( animated )
        
        if( self.isBeaconRanging == true ) {
            // Beacon の監視を停止する
            self.locationManager.stopRangingBeacons(in: self.beaconRegion);
            self.isBeaconRanging = false;
            print("stop monitoring Beacons")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    /*
    セクションの数を返す.
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
    セクションのタイトルを返す.
    */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "\(self.msgInOut) + \(self.msgStatus) "
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beaconLists.count
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        
        let beacon : CLBeacon = self.beaconLists[indexPath.row] as! CLBeacon
        
        let major = beacon.major.intValue
        let minor = beacon.minor.intValue
        let accuracy = beacon.accuracy
        let rssi = beacon.rssi
        
        var proximity = ""
        
        switch (beacon.proximity) {
        case CLProximity.unknown:
            print("Proximity: Unknown");
            proximity = "Unknown"
            break;
            
        case CLProximity.far:
            print("Proximity: Far");
            proximity = "Far"
            break;
            
        case CLProximity.near:
            print("Proximity: Near");
            proximity = "Near"
            break;
            
        case CLProximity.immediate:
            print("Proximity: Immediate");
            proximity = "Immediate"
            break;
        }
        
        cell.textLabel?.text = "major=\(major) minor=\(minor) rssi=\(rssi)"
        cell.detailTextLabel?.text = "proximity=\(proximity) accuracy=\(accuracy)"
        
        return cell
    }
    
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        let lat = manager.location!.coordinate.latitude
        let lon = manager.location!.coordinate.longitude
        
        self.location = "(\(lat),\(lon))"
        
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
        print("locationManager error", terminator: "")
    }
    
    
    /*
    (Delegate) 認証のステータスがかわったら呼び出される.
    */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示
        var statusStr = "";
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
            if manager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
                manager.requestAlwaysAuthorization()
            }
            
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
        case .authorizedAlways:
            statusStr = "AuthorizedAlways"
            // 監視を開始する
            manager.startMonitoring(for: self.beaconRegion);
            
        case .authorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        print(" CLAuthorizationStatus: \(statusStr)")
        
    }
    
    /*
    STEP2(Delegate): LocationManagerがモニタリングを開始したというイベントを受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        print("didStartMonitoringForRegion");
        
        // STEP3: この時点でビーコンがすでにRegion内に入っている可能性があるので、その問い合わせを行う
        // (Delegate didDetermineStateが呼ばれる: STEP4)
        manager.requestState(for: self.beaconRegion);
    }
    
    /*
    STEP4(Delegate): 現在リージョン内にいるかどうかの通知を受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {
        
        print("locationManager: didDetermineState \(state)")
        
        switch (state) {
            
        case .inside: // リージョン内にいる
            print("CLRegionStateInside:");
            
            // STEP5: すでに入っている場合は、そのままRangingをスタートさせる
            // (Delegate didRangeBeacons: STEP6)
            manager.startRangingBeacons(in: self.beaconRegion);
            self.isBeaconRanging = true
            
            self.msgStatus = "Inside"
            break;
            
        case .outside:
            print("CLRegionStateOutside:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
            
            self.msgStatus = "Outside"
            
            break;
            
        case .unknown:
            print("CLRegionStateUnknown:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
            
            self.msgStatus = "Unknown"
            
        }
        self.tblView.reloadData()
        
    }
    
    /*
    STEP6(Delegate): ビーコンがリージョン内に入り、その中のビーコンをNSArrayで渡される.
    */
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        // 配列をリセット
        beaconLists = NSMutableArray()
        
        // 範囲内で検知されたビーコンはこのbeaconsにCLBeaconオブジェクトとして格納される
        // rangingが開始されると１秒毎に呼ばれるため、beaconがある場合のみ処理をするようにすること.
        if(beacons.count > 0){
            
            // STEP7: 発見したBeaconの数だけLoopをまわす
            for i in 0 ..< beacons.count {
                
                let beacon = beacons[i]
                
                self.beaconLists.add(beacon)
            }
        }
        self.tblView.reloadData()
        
    }
    
    /*
    (Delegate) リージョン内に入ったというイベントを受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion");
        
        // Rangingを始める
        manager.startRangingBeacons(in: self.beaconRegion);
        self.isBeaconRanging = true
        
        self.msgInOut = "Enter Region"
        self.tblView.reloadData()
        
    }
    
    /*
    (Delegate) リージョンから出たというイベントを受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        NSLog("didExitRegion");
        
        // Rangingを停止する
        manager.stopRangingBeacons(in: self.beaconRegion);
        self.isBeaconRanging = false;
        
        self.msgInOut = "Exit Region"
        self.tblView.reloadData()
        
    }
    
    
}

