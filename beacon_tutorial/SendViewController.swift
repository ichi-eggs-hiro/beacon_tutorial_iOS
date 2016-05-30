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
    var uuid:NSUUID? = NSUUID(UUIDString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
    
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
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // Beacon に関する初期化
        self.uuid = appDelegate.scan_uuid!

        
        var offset : CGFloat = (self.view.frame.height - self.imgNoSend.size.height) / 2
        let btnX = (self.view.frame.width - self.imgNoSend.size.width) / 2
        
        self.btnSend = UIButton(frame: CGRectMake(btnX,offset,self.imgNoSend.size.width,self.imgNoSend.size.height))
        self.btnSend.setImage(self.imgNoSend, forState: UIControlState.Normal)
        self.btnSend.tag = 1
        self.btnSend.addTarget(self, action: #selector(SendViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.btnSend)
        
        offset += self.imgNoSend.size.height + 10.0

        
        self.lblUUID = UILabel()
        self.lblUUID.frame = CGRectMake(10.0, offset, self.view.frame.width, 20.0 )
        self.lblUUID.text = "UUID : \(self.uuid!.UUIDString)"
        self.lblUUID.textAlignment = NSTextAlignment.Left
        self.lblUUID.font = UIFont.systemFontOfSize(14)
        self.lblUUID.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblUUID.numberOfLines = 0
        self.lblUUID.sizeToFit()
        self.view.addSubview(self.lblUUID)
        
        offset += self.lblUUID.frame.size.height

        self.lblMajor = UILabel()
        self.lblMajor.frame = CGRectMake(10.0, offset, self.view.frame.width, 20.0 )
        self.lblMajor.text = "Major : \(self.major)"
        self.lblMajor.textAlignment = NSTextAlignment.Left
        self.lblMajor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMajor.numberOfLines = 0
        self.lblMajor.sizeToFit()
        self.view.addSubview(self.lblMajor)

        offset += self.lblMajor.frame.size.height

        self.lblMinor = UILabel()
        self.lblMinor.frame = CGRectMake(10.0, offset, self.view.frame.width, 20.0 )
        self.lblMinor.text = "Major : \(self.minor)"
        self.lblMinor.textAlignment = NSTextAlignment.Left
        self.lblMinor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblMinor.numberOfLines = 0
        self.lblMinor.sizeToFit()
        self.view.addSubview(self.lblMinor)

        
        // PeripheralManagerを定義.
        pheripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        

    }
    
    override func viewWillAppear( animated: Bool ) {
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SendViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( animated: Bool ) {
        super.viewDidDisappear( animated )
        
        if( self.status == true ) {
            stop_sending()
        }
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
            
            if( self.status == false ) {
                // 送信開始
                self.status = true
                self.btnSend.setImage(self.imgSending, forState: UIControlState.Normal)
                start_sending()
            } else {
                // 送信終了
                self.status = false
                self.btnSend.setImage(self.imgNoSend, forState: UIControlState.Normal)
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
        let beaconPeripheralData = NSDictionary(dictionary: beaconRegion.peripheralDataWithMeasuredPower(nil))
        
        print(beaconRegion.peripheralDataWithMeasuredPower(nil))
        print(beaconPeripheralData.description)
        
        // Advertisingを発信.
        pheripheralManager.startAdvertising((beaconPeripheralData as! [String : AnyObject]))
        
    }
    
    func stop_sending() {
        print("stop Sending Beacon")
        
        pheripheralManager.stopAdvertising()
    }
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState")
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        print("peripheralManagerDidStartAdvertising")
    }

}

