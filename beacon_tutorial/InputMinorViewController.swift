//
//  InputMinorViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/20.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import UIKit

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
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.scan_Minor = appDelegate.scan_minor
        if( self.scan_Minor == -1 ) {
            self.isMinor = false
            
        } else {
            self.isMinor = true
            
        }
        
        
        // Controllerのタイトルを設定する.
        self.title = "監視Minor設定"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRectMake(0,0,self.view.frame.width, self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        
        let lblDesc1:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc1.text = "監視対象ビーコン領域のMinor"
        lblDesc1.textAlignment = NSTextAlignment.Left
        lblDesc1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 10.0
        
        lblMinor = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        if( self.isMinor == false ) {
            lblMinor.text = "未指定"
        } else {
            lblMinor.text = "Minor=\(self.scan_Minor)"
        }
        lblMinor.textAlignment = NSTextAlignment.Left
        lblMinor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        scrView.addSubview(lblMinor)
        offset += lblMinor.frame.size.height + 15.0
        
        let lblDesc2:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc2.text = "Minor値を指定して監視する場合は、Minor値を指定するを選択してください。"
        lblDesc2.textAlignment = NSTextAlignment.Left
        lblDesc2.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height + 15.0
        
        // Swicthを作成する.
        switchMinor = UISwitch()
        switchMinor.layer.position = CGPoint(x: 40.0, y: offset + 10.0)
        switchMinor.tintColor = UIColor.blackColor()
        switchMinor.on = self.isMinor
        switchMinor.addTarget(self, action: #selector(InputMinorViewController.onClickSwicth(_:)), forControlEvents: UIControlEvents.ValueChanged)
        scrView.addSubview(switchMinor)
        
        lblSwitchMinor = UILabel(frame: CGRectMake(70,offset,self.view.frame.width - 70, 20 ))
        if( self.isMinor == false ) {
            lblSwitchMinor.text = "未指定"
        } else {
            lblSwitchMinor.text = "Minor値を指定する"
        }
        lblSwitchMinor.textAlignment = NSTextAlignment.Left
        lblSwitchMinor.lineBreakMode = NSLineBreakMode.ByWordWrapping
        scrView.addSubview(lblSwitchMinor)
        
        offset += lblSwitchMinor.frame.size.height + 25.0
        
        txtMinor = UITextField(frame: CGRectMake(50, offset, 160,30))
        txtMinor.text = ""
        txtMinor.delegate = self
        txtMinor.tag = 1
        txtMinor.borderStyle = UITextBorderStyle.RoundedRect
        txtMinor.keyboardType = UIKeyboardType.NumberPad
        txtMinor.returnKeyType = UIReturnKeyType.Done
        txtMinor.enabled = false
        scrView.addSubview(txtMinor)
        
        offset += txtMinor.frame.size.height + 5.0
        
        lblErr = UILabel(frame: CGRectMake(50,offset,self.view.frame.width - 60, 20 ))
        lblErr.text = "エラーメッセージ"
        lblErr.textColor = UIColor.redColor()
        lblErr.textAlignment = NSTextAlignment.Left
        lblErr.lineBreakMode = NSLineBreakMode.ByWordWrapping
        scrView.addSubview(lblErr)
        
        offset += lblErr.frame.size.height + 15.0
        
        
        let lblDesc3:UILabel = UILabel(frame: CGRectMake(10,offset,self.view.frame.width - 20, 20 ))
        lblDesc3.text = "Minor値は 0〜65535 の範囲"
        lblDesc3.textAlignment = NSTextAlignment.Left
        lblDesc3.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDesc3.numberOfLines = 0
        lblDesc3.sizeToFit()
        scrView.addSubview(lblDesc3)
        offset += lblDesc3.frame.size.height + 15.0
        
        btnSet = UIButton(frame: CGRectMake(20,offset,self.view.frame.size.width - 40,25.0))
        btnSet.setTitle("設定", forState: .Normal)
        btnSet.backgroundColor = UIColor.grayColor()
        btnSet.layer.masksToBounds = true
        btnSet.tag = 1
        btnSet.addTarget(self, action: #selector(InputMinorViewController.onClickButton(_:)), forControlEvents: .TouchUpInside)
        scrView.addSubview(self.btnSet)
        
        offset += btnSet.frame.size.height + 15.0
        
        scrView.contentSize = CGSizeMake(self.view.frame.width, offset + (self.view.frame.height / 2) )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InputMinorViewController.tapGesture(_:)))
        self.scrView.addGestureRecognizer(tap)
        
        
        refresh()
    }
    
    override func viewWillAppear( animated: Bool ) {
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InputMinorViewController.onOrientationChange(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    // 端末の向きがかわったら呼び出される.
    func onOrientationChange(notification: NSNotification){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    タップイベント.
    */
    internal func tapGesture(sender: UITapGestureRecognizer){
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
    
    internal func onClickSwicth(sender: UISwitch){
        
        if sender.on {
            lblSwitchMinor.text = "Minor値を指定する"
            isMinor = true
            txtMinor.enabled = true
            
            
        }
        else {
            lblSwitchMinor.text = "未指定"
            isMinor = false
            txtMinor.enabled = false
            
            
        }
    }
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
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
        self.scan_Minor = wkMinor
        refresh()
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    /*
    ボタンイベント
    */
    internal func onClickButton(sender: UIButton){
        
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
    
    func isValidMinor(str: String) -> Bool {
        let pattern = "^[0-9]+$"
        let ret = Regexp(pattern).isMatch(str)
        return ret
    }
    
    func showAlert( msg:String ) {
        // UIAlertControllerを作成する.
        let myAlert: UIAlertController = UIAlertController(title: "Beacon入門", message: msg, preferredStyle: .Alert)
        
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
