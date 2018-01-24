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
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.logData = appDelegate.logData

        
        // Controllerのタイトルを設定する.
        self.title = "ログの確認"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        self.imgCheckLog = UIImage(named: "btn_checklog.png")
        self.imgSendMail = UIImage(named: "btn_sendmail.png")
        self.imgClearLog = UIImage(named: "btn_clearlog.png")
        
        var offset : CGFloat = 0.0
        
        let btnX = (self.view.frame.width - self.imgCheckLog.size.width) / 2
        
        self.lblDesc1 = UILabel()
        self.lblDesc1.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc1.text = "「ビーコン受信+地図」で、ビーコン検出時のログを保存しています。"
        self.lblDesc1.textAlignment = NSTextAlignment.left
        self.lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc1.numberOfLines = 0
        self.lblDesc1.sizeToFit()
        self.scrView.addSubview(self.lblDesc1)
        
        offset += self.lblDesc1.frame.size.height + 15.0

        self.lblDesc2 = UILabel()
        self.lblDesc2.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc2.text = "ログを一覧で確認できます。"
        self.lblDesc2.textAlignment = NSTextAlignment.left
        self.lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc2.numberOfLines = 0
        self.lblDesc2.sizeToFit()
        self.scrView.addSubview(self.lblDesc2)
        
        offset += self.lblDesc2.frame.size.height + 15.0

        
        self.btnCheckLog = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgCheckLog.size.width,height: self.imgCheckLog.size.height))
        self.btnCheckLog.setImage(self.imgCheckLog, for: UIControlState())
        self.btnCheckLog.tag = 1
        self.btnCheckLog.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), for: .touchUpInside)
        self.scrView.addSubview(self.btnCheckLog)
        
        offset += self.btnCheckLog.frame.size.height + 15.0
        
        
        self.lblDesc3 = UILabel()
        self.lblDesc3.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        self.lblDesc3.text = "ログをメールで送信できます。"
        self.lblDesc3.textAlignment = NSTextAlignment.left
        self.lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc3.numberOfLines = 0
        self.lblDesc3.sizeToFit()
        self.scrView.addSubview(self.lblDesc3)
        
        offset += self.lblDesc3.frame.size.height + 15.0

        self.btnSendMail = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgSendMail.size.width,height: self.imgSendMail.size.height))
        self.btnSendMail.setImage(self.imgSendMail, for: UIControlState())
        self.btnSendMail.tag = 2
        self.btnSendMail.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), for: .touchUpInside)
        self.scrView.addSubview(self.btnSendMail)
        
        offset += self.btnSendMail.frame.size.height + 15.0

        self.lblDesc4 = UILabel()
        self.lblDesc4.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0 , height: 20.0 )
        self.lblDesc4.text = "ログをクリア（初期化）します。"
        self.lblDesc4.textAlignment = NSTextAlignment.left
        self.lblDesc4.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.lblDesc4.numberOfLines = 0
        self.lblDesc4.sizeToFit()
        self.scrView.addSubview(self.lblDesc4)
        
        offset += self.lblDesc4.frame.size.height + 15.0
        
        self.btnClearLog = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgClearLog.size.width,height: self.imgClearLog.size.height))
        self.btnClearLog.setImage(self.imgClearLog, for: UIControlState())
        self.btnClearLog.tag = 3
        self.btnClearLog.addTarget(self, action: #selector(CheckLogDescViewController.onClickButton(_:)), for: .touchUpInside)
        self.scrView.addSubview(self.btnClearLog)
        
        offset += self.btnClearLog.frame.size.height + 15.0
        
        /// 画面サイズよりも大きくなったら
        if( offset > self.scrView.frame.height ) {
            self.scrView.contentSize = CGSize(width: self.view.frame.width, height: offset + 20.0 )
        }

    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(CheckLogDescViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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
            let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: "ログをクリアしました。", preferredStyle: .alert)
            
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
        self.present(mailViewController, animated: true) {}
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
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
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

