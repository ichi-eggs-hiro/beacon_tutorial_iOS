//
//  Recv1ViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/09.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import CoreLocation


class Recv1ViewController: UIViewController,CLLocationManagerDelegate {
    
    // CoreLocation
    var locationManager:CLLocationManager!
    var beaconRegion:CLBeaconRegion!
    var uuid : UUID!
    var major : NSNumber = -1
    var minor : NSNumber = -1
    
    var scrView:UIScrollView!
    var lblStatus:UILabel!
    var lblUUID:UILabel!
    var lblMajor:UILabel!
    var lblMinor:UILabel!
    
    
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
        let identifierStr:NSString = "TownBeacon"
        
        
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
        
        
        // iOS8 以降の　使用許可取得処理
        if( UIDevice.current.systemVersion.hasPrefix("8") ) {
            
            // セキュリティ認証のステータスを取得
            let status = CLLocationManager.authorizationStatus()
            
            // まだ認証が得られていない場合は、認証ダイアログを表示
            if(status == CLAuthorizationStatus.notDetermined) {

                self.locationManager.requestAlwaysAuthorization()

            }
        }
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.notDetermined) {
            
            self.locationManager.requestAlwaysAuthorization()
            
        }
        
        
        // 現在地の取得のための設定
        // 取得精度の設定.
        // locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        // locationManager.distanceFilter = 100
        
        // 位置情報の取得開始
        // locationManager.startUpdatingLocation()
        
        
        
        
        // 画面の初期化
        self.title = "ビーコン領域の観測"
        
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        lblStatus = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblStatus.text = "STATUS="
        lblStatus.font = UIFont.systemFont(ofSize: 20)
        self.scrView.addSubview(lblStatus)
        offset += 25
        
        lblUUID = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblUUID.text = "\(self.uuid.uuidString)"
        lblUUID.font = UIFont.systemFont(ofSize: 14)
        self.scrView.addSubview(lblUUID)
        offset += 20

        lblMajor = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 30, height: 20 ))
        if( self.major == -1 ) {
            lblMajor.text = "Major=未指定"
        } else {
            lblMajor.text = "Major=\(self.major)"
        }
        lblMajor.font = UIFont.systemFont(ofSize: 16)
        self.scrView.addSubview(lblMajor)
        offset += 20

        lblMinor = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 30, height: 20 ))
        if( self.minor == -1 ) {
            lblMinor.text = "Minor=未指定"
        } else {
            lblMinor.text = "Minor=\(self.minor)"
        }
        lblMinor.font = UIFont.systemFont(ofSize: 16)
        self.scrView.addSubview(lblMinor)
        offset += 20
        
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
            
            self.lblStatus.text = "STATUS=Inside"
            break;
            
        case .outside:
            print("CLRegionStateOutside:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。

            self.lblStatus.text = "STATUS=Outside"

            break;
            
        case .unknown:
            print("CLRegionStateUnknown:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。

            self.lblStatus.text = "STATUS=Unknown"

        }

    }

    
    /*
    STEP6(Delegate): ビーコンがリージョン内に入り、その中のビーコンをNSArrayで渡される.
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        // 配列をリセット
        beaconLists = NSMutableArray()
        
        // 範囲内で検知されたビーコンはこのbeaconsにCLBeaconオブジェクトとして格納される
        // rangingが開始されると１秒毎に呼ばれるため、beaconがある場合のみ処理をするようにすること.
        if(beacons.count > 0){
            
            // STEP7: 発見したBeaconの数だけLoopをまわす
            for var i = 0; i < beacons.count; i++ {
                
                let beacon = beacons[i]
                
                self.beaconLists.addObject(beacon)
            }
        }
        self.tblView.reloadData()

    }
    */
    
    /*
    (Delegate) リージョン内に入ったというイベントを受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion");
        

        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: "ビーコン領域に入りました。", preferredStyle: .alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
        }
        
        // OKのActionを追加する.
        myAlert.addAction(myOkAction)
        
        // UIAlertを発動する.
        present(myAlert, animated: true, completion: nil)
    }
    
    /*
    (Delegate) リージョンから出たというイベントを受け取る.
    */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        NSLog("didExitRegion");
        
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: "ビーコン領域から外に出ました。", preferredStyle: .alert)
        
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

