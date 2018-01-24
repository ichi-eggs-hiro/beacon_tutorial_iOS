//
//  SendDescViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit
import CoreLocation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SendDescViewController: UIViewController,UITextFieldDelegate {
    
    var appDelegate:AppDelegate!

    var scrView:UIScrollView!

    var btnExec : UIButton!
    var imgExec : UIImage!
    
    var uuid:UUID!
    var sendMajor:CLBeaconMajorValue = 100
    var sendMinor:CLBeaconMinorValue = 1
    
    var validNumberMajor:Bool = true
    var validNumberMinor:Bool = true
    
    var txtMajor: UITextField!
    var txtMinor: UITextField!
    
    var lblErrMajor:UILabel!
    var lblErrMinor:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.uuid = appDelegate.scan_uuid as UUID!
        

        
        // Controllerのタイトルを設定する.
        self.title = "ビーコン発信（説明)"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        self.imgExec = UIImage(named: "btn_execute.png")
        
        var offset : CGFloat = 0.0
        
        let lblDesc1 = UILabel()
        lblDesc1.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width, height: 20.0 )
        lblDesc1.text = "ビーコン信号を発信します。"
        lblDesc1.textAlignment = NSTextAlignment.left
        lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 15.0
        
        let lblDesc2 = UILabel()
        lblDesc2.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        lblDesc2.text = "送信するビーコン信号の設定"
        lblDesc2.textAlignment = NSTextAlignment.left
        lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height
        
        let lblUUID = UILabel()
        lblUUID.frame = CGRect(x: 10.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        lblUUID.text = "\(self.uuid.uuidString)"
        lblUUID.textAlignment = NSTextAlignment.left
        lblUUID.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblUUID.font = UIFont.systemFont(ofSize: 14)
        lblUUID.numberOfLines = 0
        lblUUID.sizeToFit()
        scrView.addSubview(lblUUID)
        offset += lblUUID.frame.size.height + 15.0
        
        let lblDesc3 = UILabel()
        lblDesc3.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        lblDesc3.text = "UUIDは、「設定」画面から変更できます。"
        lblDesc3.textAlignment = NSTextAlignment.left
        lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        scrView.addSubview(lblDesc3)
        offset += lblDesc3.frame.size.height + 15.0

        
        let lblMajor = UILabel()
        lblMajor.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        lblMajor.text = "Major"
        lblMajor.textAlignment = NSTextAlignment.left
        lblMajor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblMajor)
        offset += lblMajor.frame.size.height
        
        txtMajor = UITextField(frame: CGRect(x: 50, y: offset, width: 160,height: 30))
        txtMajor.text = "\(self.sendMajor)"
        txtMajor.delegate = self
        txtMajor.tag = 1
        txtMajor.borderStyle = UITextBorderStyle.roundedRect
        txtMajor.keyboardType = UIKeyboardType.numberPad
        txtMajor.returnKeyType = UIReturnKeyType.done
        scrView.addSubview(txtMajor)
        
        offset += txtMajor.frame.size.height + 5.0
        
        lblErrMajor = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrMajor.text = ""
        lblErrMajor.textColor = UIColor.red
        lblErrMajor.textAlignment = NSTextAlignment.left
        lblErrMajor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrMajor)
        
        offset += lblErrMajor.frame.size.height + 15.0
        
        let lblMinor = UILabel()
        lblMinor.frame = CGRect(x: 20.0, y: offset, width: self.view.frame.width - 20.0, height: 20.0 )
        lblMinor.text = "Minor"
        lblMinor.textAlignment = NSTextAlignment.left
        lblMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblMinor)
        offset += lblMinor.frame.size.height
        
        txtMinor = UITextField(frame: CGRect(x: 50, y: offset, width: 160,height: 30))
        txtMinor.text = "\(self.sendMinor)"
        txtMinor.delegate = self
        txtMinor.tag = 2
        txtMinor.borderStyle = UITextBorderStyle.roundedRect
        txtMinor.keyboardType = UIKeyboardType.numberPad
        txtMinor.returnKeyType = UIReturnKeyType.done
        scrView.addSubview(txtMinor)
        
        offset += txtMajor.frame.size.height + 5.0
        
        lblErrMinor = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrMinor.text = ""
        lblErrMinor.textColor = UIColor.red
        lblErrMinor.textAlignment = NSTextAlignment.left
        lblErrMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrMinor)
        
        offset += lblErrMinor.frame.size.height + 15.0

        
        let lblDesc4:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc4.text = "Major,Minor値は 0〜65535 の範囲"
        lblDesc4.textAlignment = NSTextAlignment.left
        lblDesc4.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc4.numberOfLines = 0
        lblDesc4.sizeToFit()
        scrView.addSubview(lblDesc4)
        offset += lblDesc4.frame.size.height + 15.0
        

        
        let btnX = (self.view.frame.width - self.imgExec.size.width) / 2
        
        self.btnExec = UIButton(frame: CGRect(x: btnX,y: offset,width: self.imgExec.size.width,height: self.imgExec.size.height))
        self.btnExec.setImage(self.imgExec, for: UIControlState())
        self.btnExec.tag = 1
        self.btnExec.addTarget(self, action: #selector(SendDescViewController.onClickButton(_:)), for: .touchUpInside)
        self.scrView.addSubview(self.btnExec)

        
        scrView.contentSize = CGSize(width: self.view.frame.width, height: offset + (self.view.frame.height / 2) )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SendDescViewController.tapGesture(_:)))
        self.scrView.addGestureRecognizer(tap)


    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(SendDescViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    @objc func onOrientationChange(_ notification: Notification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    タップイベント.
    */
    @objc internal func tapGesture(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    /*
    ボタンイベント
    */
    @objc internal func onClickButton(_ sender: UIButton){
        
        self.view.endEditing(true)

        if( sender.tag == 1 ) {
            
            if( self.validNumberMajor == false || self.validNumberMinor == false ) {
                showAlert("Major値またはMinor値が正しくありません。")
                return
            }

            // 移動先のViewを定義する.
            let vc = SendViewController()
            vc.major = self.sendMajor
            vc.minor = self.sendMinor
            
            // SecondViewに移動する.
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        // 数字とA〜F　のチェック
        let valid = isValidNumber(textField.text!)
        
        switch( textField.tag ) {
        case 1:
            self.validNumberMajor = false

            lblErrMajor.text = ""
            if( valid == false ) {
                lblErrMajor.text = "数値を入力してください。"
                return false
            }
            let wkStr = textField.text!
            let wkMajor = UInt16(wkStr)
            
            if( wkMajor < 0 || wkMajor > 65535 ) {
                lblErrMajor.text = "0〜65535を超えています"
                return false
            }

            self.sendMajor = wkMajor!
            self.validNumberMajor = true
            break
        case 2:
            self.validNumberMinor = false
            
            lblErrMinor.text = ""
            if( valid == false ) {
                lblErrMinor.text = "数値を入力してください。"
                return false
            }
            let wkStr = textField.text!
            let wkMinor = UInt16(wkStr)
            
            if( wkMinor < 0 || wkMinor > 65535 ) {
                lblErrMinor.text = "0〜65535を超えています"
                return false
            }
            
            self.sendMinor = wkMinor!
            self.validNumberMinor = true
            break
        default: break
        }
        
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func isValidNumber(_ str: String) -> Bool {
        let pattern = "^[0-9]+$"
        let ret = Regexp(pattern).isMatch(str)
        return ret
    }
    
    func showAlert( _ msg:String ) {
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: msg, preferredStyle: .alert)
        
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
