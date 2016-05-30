//
//  Recv3ViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/10.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class Recv3ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MapView.
    var mapView : MKMapView!
    var targetPin: MKPointAnnotation? = nil
    var timerObj : NSTimer!
    
    var lat : CLLocationDegrees!
    var lon : CLLocationDegrees!
    
    // CoreLocation
    var locationManager:CLLocationManager!
    var beaconRegion:CLBeaconRegion!
    var uuid : NSUUID!
    var major : NSNumber = -1
    var minor : NSNumber = -1
    
    var isBeaconRanging : Bool = false
    
    // 受信したBeaconのリスト
    var beaconLists : NSMutableArray!
    
    // メッセージ
    var lblMsg1 : UILabel!
    var lblMsg2 : UILabel!
    var lblMsg3 : UILabel!
    
    // ログ
    var logData:Logs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ロケーションマネージャの作成.
        locationManager = CLLocationManager()
        locationManager.delegate = self         // デリゲートを自身に設定.
        
        // iOS8 以降の　使用許可取得処理
        if( UIDevice.currentDevice().systemVersion.hasPrefix("8") ) {
            
            // セキュリティ認証のステータスを取得
            let status = CLLocationManager.authorizationStatus()
            
            // まだ認証が得られていない場合は、認証ダイアログを表示
            if(status == CLAuthorizationStatus.NotDetermined) {
                
                self.locationManager.requestAlwaysAuthorization()
                
            }
        }
        
        
        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid!
        self.major = appDelegate.scan_major
        self.minor = appDelegate.scan_minor
        
        self.logData = appDelegate.logData
        
        
        // 現在地の取得のための設定
        // 取得精度の設定.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        locationManager.distanceFilter = 100
        
        // 位置情報の取得開始
        locationManager.startUpdatingLocation()
        
        // BeaconのIdentifierを設定.
        let identifierStr:NSString = "BeaconBank"
        
        
        // ビーコン領域の初期化
        self.beaconRegion = CLBeaconRegion(proximityUUID:uuid, identifier:identifierStr as String)
        
        if( self.major != -1 && self.minor == -1 ) {
            let majorVal:UInt16 = numericCast(self.major.integerValue)
            self.beaconRegion = CLBeaconRegion(proximityUUID:uuid, major: majorVal, identifier: identifierStr as String)
        }
        
        if( self.major != -1 && self.minor != -1 ) {
            let majorVal:UInt16 = numericCast(self.major.integerValue)
            let minorVal:UInt16 = numericCast(self.major.integerValue)
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
        
        self.isBeaconRanging = true
        
        
        // Controllerのタイトルを設定する.
        self.title = "ビーコン受信＋MAP"
        self.view.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        
        // MapViewの生成.
        mapView = MKMapView()
        
        // MapViewのサイズを画面全体に.
        mapView.frame = self.view.bounds
        // mapView.frame = CGRectMake(0, 0, self.view.frame.width,  self.view.frame.height - 40.0 )
        
        // Delegateを設定.
        mapView.delegate = self
        
        // MapViewをViewに追加.
        self.view.addSubview(mapView)
        
        // 中心点の緯度経度. 35.681391, 139.766052
        let centerLat: CLLocationDegrees = 35.681391
        let centerLon: CLLocationDegrees = 139.766052
        let centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(centerLat, centerLon)
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 800
        let myLonDist : CLLocationDistance = 800
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, myLatDist, myLonDist);
        
        // MapViewに反映.
        mapView.setRegion(myRegion, animated: true)
        
        
        // メッセージラベル
        let msgPosy : CGFloat = self.view.frame.height - 60
        self.lblMsg1 = UILabel()
        self.lblMsg1.frame = CGRectMake(10.0, msgPosy, self.view.frame.width - 20, 20.0 )
        self.lblMsg1.text = ""
        self.lblMsg1.textAlignment = NSTextAlignment.Left
        self.lblMsg1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMsg1.numberOfLines = 1
        self.lblMsg1.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        self.view.addSubview(self.lblMsg1)

        self.lblMsg2 = UILabel()
        self.lblMsg2.frame = CGRectMake(10.0, msgPosy + 20.0, self.view.frame.width - 20, 20.0 )
        self.lblMsg2.text = ""
        self.lblMsg2.textAlignment = NSTextAlignment.Left
        self.lblMsg2.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMsg2.numberOfLines = 1
        self.lblMsg2.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        self.view.addSubview(self.lblMsg2)

        self.lblMsg3 = UILabel()
        self.lblMsg3.frame = CGRectMake(10.0, msgPosy + 40.0, self.view.frame.width - 20, 20.0 )
        self.lblMsg3.text = ""
        self.lblMsg3.textAlignment = NSTextAlignment.Left
        self.lblMsg3.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMsg3.numberOfLines = 1
        self.lblMsg3.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        self.view.addSubview(self.lblMsg3)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Regionが変更された時に呼び出されるメソッド.
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
    }
    
    // 画面が再表示される時
    override func viewWillAppear( animated: Bool ) {
        
        super.viewWillAppear( animated )
        
        if( self.isBeaconRanging == false ) {
            // Beacon の監視を再開する。
            self.locationManager.startRangingBeaconsInRegion(self.beaconRegion);
            self.isBeaconRanging = true;
            print("restart monitoring Beacons")
        }
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( animated: Bool ) {
        super.viewDidDisappear( animated )
        
        if( self.isBeaconRanging == true ) {
            // Beacon の監視を停止する
            self.locationManager.stopRangingBeaconsInRegion(self.beaconRegion);
            self.isBeaconRanging = false;
            print("stop monitoring Beacons")
        }
    }
    
    func setCenter( msg : String ) {
        let centerLat: CLLocationDegrees = self.lat
        let centerLon: CLLocationDegrees = self.lon
        let centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(centerLat, centerLon)
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 800
        let myLonDist : CLLocationDistance = 800
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, myLatDist, myLonDist);
        
        // MapViewに反映.
        mapView.setRegion(myRegion, animated: true)
        
        //
        // pin を表示する
        //
        
        let now = NSDate() // 現在日時の取得
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.dateStyle = .MediumStyle
        
        
        let pin = MKPointAnnotation()
        
        // 座標を設定.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.lat, self.lon)
        pin.coordinate = center
        
        // タイトルを設定.
        pin.title = dateFormatter.stringFromDate(now)       // -> YYYY/MM/DD HH:MM:SS
        pin.subtitle = msg
        
        // MapViewにピンを追加.
        mapView.addAnnotation(pin)
    }
    
    func updateMessage( msg : String ) {
        self.lblMsg1.text = msg
    }

    func updateBeacon( msg : String ) {
        self.lblMsg2.text = msg
    }

    func updateLocation( msg : String ) {
        self.lblMsg3.text = msg
    }
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        
        self.lat = manager.location!.coordinate.latitude
        self.lon = manager.location!.coordinate.longitude
        
        let msg : String = "緯度経度 : \(self.lat), \(self.lon)"
        updateLocation(msg)
        
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        print("locationManager error", terminator: "")
    }
    
    /*
    (Delegate) 認証のステータスがかわったら呼び出される.
    */
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        print("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示
        var statusStr = "";
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
            if manager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
                manager.requestAlwaysAuthorization()
            }
            
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .AuthorizedAlways:
            statusStr = "AuthorizedAlways"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        print(" CLAuthorizationStatus: \(statusStr)")
        
        manager.startMonitoringForRegion(self.beaconRegion);
    }
    
    /*
    STEP2(Delegate): LocationManagerがモニタリングを開始したというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        
        print("didStartMonitoringForRegion");
        
        // STEP3: この時点でビーコンがすでにRegion内に入っている可能性があるので、その問い合わせを行う
        // (Delegate didDetermineStateが呼ばれる: STEP4)
        manager.requestStateForRegion(self.beaconRegion);
    }
    
    /*
    STEP4(Delegate): 現在リージョン内にいるかどうかの通知を受け取る.
    */
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion) {
        
        print("locationManager: didDetermineState \(state)")
        
        switch (state) {
            
        case .Inside: // リージョン内にいる
            print("CLRegionStateInside:");
            
            // STEP5: すでに入っている場合は、そのままRangingをスタートさせる
            // (Delegate didRangeBeacons: STEP6)
            manager.startRangingBeaconsInRegion(self.beaconRegion);
            self.isBeaconRanging = true
            
            updateMessage("ビーコンを検出しました。")
            break;
            
        case .Outside:
            print("CLRegionStateOutside:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
            
            updateMessage("ビーコンが見つかりません。")
            
            break;
            
        case .Unknown:
            print("CLRegionStateUnknown:");
            // 外にいる、またはUknownの場合はdidEnterRegionが適切な範囲内に入った時に呼ばれるため処理なし。
            
            updateMessage("不明")
            
        }
    }
    
    /*
    STEP6(Delegate): ビーコンがリージョン内に入り、その中のビーコンをNSArrayで渡される.
    */
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        // 配列をリセット
        beaconLists = NSMutableArray()
        
        // 範囲内で検知されたビーコンはこのbeaconsにCLBeaconオブジェクトとして格納される
        // rangingが開始されると１秒毎に呼ばれるため、beaconがある場合のみ処理をするようにすること.
        if(beacons.count > 0){
            
            
            // STEP7: 発見したBeaconの数だけLoopをまわす
            for i in 0 ..< beacons.count {
                
                let beacon = beacons[i]
                
                self.beaconLists.addObject(beacon)
            }
            
            checkLocation()
            
        }
        
    }
    
    /*
    (Delegate) リージョン内に入ったというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion");
        
        // Rangingを始める
        manager.startRangingBeaconsInRegion(self.beaconRegion);
        self.isBeaconRanging = true
    }
    
    /*
    (Delegate) リージョンから出たというイベントを受け取る.
    */
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        NSLog("didExitRegion");
        
        // Rangingを停止する
        manager.stopRangingBeaconsInRegion(self.beaconRegion);
        self.isBeaconRanging = false;
        
    }
    
    
    func checkLocation() {
        if( self.lat == 0 || self.lon == 0 ) {
            // 位置情報が取得できていないので、無視する。
            return
        }
        
        if(self.beaconLists.count == 0 ) {
            return
        }

        // 最も近いビーコンで計測する
        let beacon : CLBeacon = self.beaconLists[0] as! CLBeacon
        
        let major = beacon.major.integerValue
        let minor = beacon.minor.integerValue
        let rssi = beacon.rssi
        var proximity = ""
        
        switch (beacon.proximity) {
        case CLProximity.Unknown:
            proximity = "不明"
            break;
            
        case CLProximity.Far:
            proximity = "遠い"
            break;
            
        case CLProximity.Near:
            proximity = "近い"
            break;
            
        case CLProximity.Immediate:
            proximity = "極近い"
            break;
        }
        
        let msg : String = "major=\(major) minor=\(minor) rssi=\(rssi) 距離=\(proximity)"
        updateBeacon(msg)
        setCenter(msg)
        
        let now = NSDate()
        
        print(beacon.proximityUUID)
        print(beacon.major)
        print(beacon.minor)
        print(self.lat)
        print(self.lon)
        print(now)
        
        logData.Add(beacon.proximityUUID, major: beacon.major, minor: beacon.minor, lat: self.lat, lon: self.lon, d: now)
        
    }

}
