//
//  SendViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/06.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth


class SendViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var btnSend : UIButton!

    var imgNoSend : UIImage!
    var imgSending : UIImage!
    
    var lblUUID : UILabel!
    var lblMajor : UILabel!
    var lblMinor : UILabel!
    
    var status : Bool = false
    
    // PheripheralManager.
    var pheripheralManager:CBPeripheralManager!
    
    // CoreLocation
    var beaconRegion:CLBeaconRegion!
    
    // BeaconのIdentifierを設定.
    let identifierStr:NSString = "TownBeacon"
    var uuid:UUID? = UUID(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
    
    // MajorId,MinorId
    var major:CLBeaconMajorValue = 100
    var minor:CLBeaconMinorValue = 1
    
    var statusStr = "";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する.
        self.title = "ビーコン発信"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        self.imgNoSend = UIImage(named: "no_send.png")
        self.imgSending = UIImage(named: "sending.png")
        
        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid! as UUID

        
        var offset : CGFloat = (self.view.frame.height - self.imgNoSend.size.height) / 2
        let btnX = (self.view.frame.width - self.imgNoSend.size.width) / 2
        
        self.btnSend = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgNoSend.size.width,height: self.imgNoSend.size.height))
        self.btnSend.setImage(self.imgNoSend, for: UIControlState())
        self.btnSend.tag = 1
        self.btnSend.addTarget(self, action: #selector(SendViewController.onClickButton(_:)), for: .touchUpInside)
        self.view.addSubview(self.btnSend)
        
        offset += self.imgNoSend.size.height + 10.0

        
        self.lblUUID = UILabel()
        self.lblUUID.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        self.lblUUID.text = "UUID : \(self.uuid!.uuidString)"
        self.lblUUID.textAlignment = NSTextAlignment.left
        self.lblUUID.font = UIFont.systemFont(ofSize: 14)
        self.lblUUID.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblUUID.numberOfLines = 0
        self.lblUUID.sizeToFit()
        self.view.addSubview(self.lblUUID)
        
        offset += self.lblUUID.frame.size.height

        self.lblMajor = UILabel()
        self.lblMajor.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        self.lblMajor.text = "Major : \(self.major)"
        self.lblMajor.textAlignment = NSTextAlignment.left
        self.lblMajor.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblMajor.numberOfLines = 0
        self.lblMajor.sizeToFit()
        self.view.addSubview(self.lblMajor)

        offset += self.lblMajor.frame.size.height

        self.lblMinor = UILabel()
        self.lblMinor.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        self.lblMinor.text = "Major : \(self.minor)"
        self.lblMinor.textAlignment = NSTextAlignment.left
        self.lblMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblMinor.numberOfLines = 0
        self.lblMinor.sizeToFit()
        self.view.addSubview(self.lblMinor)

        
        // PeripheralManagerを定義.
        pheripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        

    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(SendViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( _ animated: Bool ) {
        super.viewDidDisappear( animated )
        
        if( self.status == true ) {
            stop_sending()
        }
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
            
            if( self.status == false ) {
                // 送信開始
                self.status = true
                self.btnSend.setImage(self.imgSending, for: UIControlState())
                start_sending()
            } else {
                // 送信終了
                self.status = false
                self.btnSend.setImage(self.imgNoSend, for: UIControlState())
                stop_sending()
            }
            
        }
    }

    func start_sending(){
        print("start Sending Beacon")
        
        
        // iBeaconのIdentifier.
        let identifier = "iBeacon"
        
        // BeaconRegionを定義.
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: major, minor: minor, identifier: identifier)
        
        // Advertisingのフォーマットを作成.
        let beaconPeripheralData = NSDictionary(dictionary: beaconRegion.peripheralData(withMeasuredPower: nil))
        
        print(beaconRegion.peripheralData(withMeasuredPower: nil))
        print(beaconPeripheralData.description)
        
        // Advertisingを発信.
        pheripheralManager.startAdvertising((beaconPeripheralData as! [String : AnyObject]))
        
    }
    
    func stop_sending() {
        print("stop Sending Beacon")
        
        pheripheralManager.stopAdvertising()
    }
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising")
    }

}

