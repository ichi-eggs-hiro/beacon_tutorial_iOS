//
//  CheckLogDescViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import MessageUI


class CheckLogDescViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var scrView : UIScrollView!

    var btnCheckLog:UIButton!
    var btnSendMail:UIButton!
    var btnClearLog:UIButton!
    
    var imgCheckLog:UIImage!
    var imgSendMail:UIImage!
    var imgClearLog:UIImage!
    
    var lblDesc1:UILabel!
    var lblDesc2:UILabel!
    var lblDesc3:UILabel!
    var lblDesc4:UILabel!
    
    // ログ
    var logData:Logs!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.logData = appDelegate.logData

        
        // Controllerのタイトルを設定する.
        self.title = "ログの確認"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        self.imgCheckLog = UIImage(named: "btn_checklog.png")
        self.imgSendMail = UIImage(named: "btn_sendmail.png")
        self.imgClearLog = UIImage(named: "btn_clearlog.png")
        
        var offset : CGFloat = 0.0
        
        let btnX = (self.view.frame.width - self.imgCheckLog.size.width) / 2
        
        self.lblDesc1 = UILabel()
        self.lblDesc1.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc1.text = "「ビーコン受信+地図」で、ビーコン検出時のログを保存しています。"
        self.lblDesc1.textAlignment = NSTextAlignment.Left
        self.lblDesc1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc1.numberOfLines = 0
        self.lblDesc1.sizeToFit()
        self.scrView.addSubview(self.lblDesc1)
        
        offset += self.lblDesc1.frame.size.height + 15.0

        self.lblDesc2 = UILabel()
        self.lblDesc2.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc2.text = "ログを一覧で確認できます。"
        self.lblDesc2.textAlignment = NSTextAlignment.Left
        self.lblDesc2.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc2.numberOfLines = 0
        self.lblDesc2.sizeToFit()
        self.scrView.addSubview(self.lblDesc2)
        
        offset += self.lblDesc2.frame.size.height + 15.0

        
        self.btnCheckLog = UIButton(frame: CGRectMake(btnX,offset,self.imgCheckLog.size.width,self.imgCheckLog.size.height))
        self.btnCheckLog.setImage(self.imgCheckLog, forState: UIControlState.Normal)
        self.btnCheckLog.tag = 1
        self.btnCheckLog.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnCheckLog)
        
        offset += self.btnCheckLog.frame.size.height + 15.0
        
        
        self.lblDesc3 = UILabel()
        self.lblDesc3.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0, 20.0 )
        self.lblDesc3.text = "ログをメールで送信できます。"
        self.lblDesc3.textAlignment = NSTextAlignment.Left
        self.lblDesc3.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc3.numberOfLines = 0
        self.lblDesc3.sizeToFit()
        self.scrView.addSubview(self.lblDesc3)
        
        offset += self.lblDesc3.frame.size.height + 15.0

        self.btnSendMail = UIButton(frame: CGRectMake(btnX,offset,self.imgSendMail.size.width,self.imgSendMail.size.height))
        self.btnSendMail.setImage(self.imgSendMail, forState: UIControlState.Normal)
        self.btnSendMail.tag = 2
        self.btnSendMail.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnSendMail)
        
        offset += self.btnSendMail.frame.size.height + 15.0

        self.lblDesc4 = UILabel()
        self.lblDesc4.frame = CGRectMake(10.0, offset, self.view.frame.width - 20.0 , 20.0 )
        self.lblDesc4.text = "ログをクリア（初期化）します。"
        self.lblDesc4.textAlignment = NSTextAlignment.Left
        self.lblDesc4.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblDesc4.numberOfLines = 0
        self.lblDesc4.sizeToFit()
        self.scrView.addSubview(self.lblDesc4)
        
        offset += self.lblDesc4.frame.size.height + 15.0
        
        self.btnClearLog = UIButton(frame: CGRectMake(btnX,offset,self.imgClearLog.size.width,self.imgClearLog.size.height))
        self.btnClearLog.setImage(self.imgClearLog, forState: UIControlState.Normal)
        self.btnClearLog.tag = 3
        self.btnClearLog.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        self.scrView.addSubview(self.btnClearLog)
        
        offset += self.btnClearLog.frame.size.height + 15.0
        
        /// 画面サイズよりも大きくなったら
        if( offset > self.scrView.frame.height ) {
            self.scrView.contentSize = CGSizeMake(self.view.frame.width, offset + 20.0 )
        }

    }
    
    override func viewWillAppear( animated: Bool ) {
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CheckLogDescViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
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
            let vc = CheckLogListViewController()
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if( sender.tag == 2 ) {
            
            sendMail()
            
        }
        
        if( sender.tag == 3 ) {
            
            self.logData.Clear()
            
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: "ログをクリアしました。", preferredStyle: .Alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                print("Action OK!!")
            }
            
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            presentViewController(myAlert, animated: true, completion: nil)

        }
    }

    func sendMail() {
        
        let subject:String = "BeaconLog"
        let message : String = self.logData.CreateCSV()
        
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = self
        // let toRecipients = ["swinget@anysystem.co.jp"]
        // let toRecipients = ["ichi.eggs.hiro@gmail.com"]
        
        mailViewController.setSubject(subject)
        // mailViewController.setToRecipients(toRecipients)
        mailViewController.setMessageBody(message, isHTML: false)
        self.presentViewController(mailViewController, animated: true) {}
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        print(result.rawValue)
        
        /*
        result.rawValue
        
        switch result.value {
        case MFMailComposeResultCancelled.value:
        println("Email Send Cancelled")
        break
        case MFMailComposeResultSaved.value:
        println("Email Saved as a Draft")
        break
        case MFMailComposeResultSent.value:
        println("Email Sent Successfully")
        break
        case MFMailComposeResultFailed.value:
        println("Email Send Failed")
        break
        default:
        break
        }
        */
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

