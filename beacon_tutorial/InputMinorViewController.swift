//
//  InputMinorViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/20.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import UIKit
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


class InputMinorViewController: UIViewController,UITextFieldDelegate {
    
    var appDelegate:AppDelegate!
    
    var lblMinor:UILabel!
    var lblSwitchMinor:UILabel!
    var lblInputMinor:UILabel!
    
    var lblErr:UILabel!
    
    var btnSet:UIButton!
    var scrView:UIScrollView!
    
    var txtMinor: UITextField!
    
    var scan_Minor:NSNumber!
    
    var switchMinor:UISwitch!
    var isMinor:Bool = false
    var isValid:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.scan_Minor = appDelegate.scan_minor
        if( self.scan_Minor == -1 ) {
            self.isMinor = false
            
        } else {
            self.isMinor = true
            
        }
        
        
        // Controllerのタイトルを設定する.
        self.title = "監視Minor設定"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        
        let lblDesc1:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc1.text = "監視対象ビーコン領域のMinor"
        lblDesc1.textAlignment = NSTextAlignment.left
        lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 10.0
        
        lblMinor = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        if( self.isMinor == false ) {
            lblMinor.text = "未指定"
        } else {
            lblMinor.text = "Minor=\(self.scan_Minor)"
        }
        lblMinor.textAlignment = NSTextAlignment.left
        lblMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblMinor)
        offset += lblMinor.frame.size.height + 15.0
        
        let lblDesc2:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc2.text = "Minor値を指定して監視する場合は、Minor値を指定するを選択してください。"
        lblDesc2.textAlignment = NSTextAlignment.left
        lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height + 15.0
        
        // Swicthを作成する.
        switchMinor = UISwitch()
        switchMinor.layer.position = CGPoint(x: 40.0, y: offset + 10.0)
        switchMinor.tintColor = UIColor.black
        switchMinor.isOn = self.isMinor
        switchMinor.addTarget(self, action: #selector(InputMinorViewController.onClickSwicth(_:)), for: UIControlEvents.valueChanged)
        scrView.addSubview(switchMinor)
        
        lblSwitchMinor = UILabel(frame: CGRect(x: 70,y: offset,width: self.view.frame.width - 70, height: 20 ))
        if( self.isMinor == false ) {
            lblSwitchMinor.text = "未指定"
        } else {
            lblSwitchMinor.text = "Minor値を指定する"
        }
        lblSwitchMinor.textAlignment = NSTextAlignment.left
        lblSwitchMinor.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblSwitchMinor)
        
        offset += lblSwitchMinor.frame.size.height + 25.0
        
        txtMinor = UITextField(frame: CGRect(x: 50, y: offset, width: 160,height: 30))
        txtMinor.text = ""
        txtMinor.delegate = self
        txtMinor.tag = 1
        txtMinor.borderStyle = UITextBorderStyle.roundedRect
        txtMinor.keyboardType = UIKeyboardType.numberPad
        txtMinor.returnKeyType = UIReturnKeyType.done
        txtMinor.isEnabled = false
        scrView.addSubview(txtMinor)
        
        offset += txtMinor.frame.size.height + 5.0
        
        lblErr = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErr.text = "エラーメッセージ"
        lblErr.textColor = UIColor.red
        lblErr.textAlignment = NSTextAlignment.left
        lblErr.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErr)
        
        offset += lblErr.frame.size.height + 15.0
        
        
        let lblDesc3:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc3.text = "Minor値は 0〜65535 の範囲"
        lblDesc3.textAlignment = NSTextAlignment.left
        lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        scrView.addSubview(lblDesc3)
        offset += lblDesc3.frame.size.height + 15.0
        
        btnSet = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnSet.setTitle("設定", for: UIControlState())
        btnSet.backgroundColor = UIColor.gray
        btnSet.layer.masksToBounds = true
        btnSet.tag = 1
        btnSet.addTarget(self, action: #selector(InputMinorViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnSet)
        
        offset += btnSet.frame.size.height + 15.0
        
        scrView.contentSize = CGSize(width: self.view.frame.width, height: offset + (self.view.frame.height / 2) )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InputMinorViewController.tapGesture(_:)))
        self.scrView.addGestureRecognizer(tap)
        
        
        refresh()
    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(InputMinorViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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
    
    func refresh() {
        if( self.isMinor == false ) {
            lblMinor.text = "未指定"
            lblSwitchMinor.text = "未指定"
        } else {
            lblMinor.text = "Minor=\(self.scan_Minor)"
            lblSwitchMinor.text = "Minor値を指定する"
            txtMinor.text = "\(self.scan_Minor)"
        }
        
        lblErr.text = ""
    }
    
    @objc internal func onClickSwicth(_ sender: UISwitch){
        
        if sender.isOn {
            lblSwitchMinor.text = "Minor値を指定する"
            isMinor = true
            txtMinor.isEnabled = true
            
            
        }
        else {
            lblSwitchMinor.text = "未指定"
            isMinor = false
            txtMinor.isEnabled = false
            
            
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
        
        isValid = false
        
        // 数字とA〜F　のチェック
        let valid = isValidMinor(textField.text!)
        let len = (textField.text! as NSString).length
        
        if( len == 0 ) {
            lblErr.text = "数値を入力してください"
            return false
        }
        if( valid == false ) {
            lblErr.text = "数値を入力してください"
            return false
        }
        
        let wkStr = textField.text!
        let wkMinor = Int(wkStr)
        
        if( wkMinor < 0 || wkMinor > 65535 ) {
            lblErr.text = "0〜65535を超えています"
            return false
            
        }
        
        isValid = true
        self.scan_Minor = wkMinor as NSNumber!
        refresh()
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    /*
    ボタンイベント
    */
    @objc internal func onClickButton(_ sender: UIButton){
        
        self.view.endEditing(true)

        
        if( sender.tag == 1 ) {
            
            if( self.isMinor == false ) {
                self.scan_Minor = -1
                appDelegate.scan_minor = -1
                
            } else {
                if( self.isValid == false ) {
                    showAlert("入力値にエラーがあります。")
                    return
                }
                appDelegate.scan_minor = self.scan_Minor
                
            }
            appDelegate.Save()
            
            showAlert("Minor値を変更しました。")
            refresh()
            
        }
        
    }
    
    func isValidMinor(_ str: String) -> Bool {
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
