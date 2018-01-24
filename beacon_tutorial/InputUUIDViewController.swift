//
//  InputUUIDViewController.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/20.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import UIKit

class InputUUIDViewController: UIViewController,UITextFieldDelegate {
    
    var appDelegate:AppDelegate!
    
    var lblFullUUID:UILabel!

    var lblErrUUIDb1:UILabel!
    var lblErrUUIDb2:UILabel!
    var lblErrUUIDb3:UILabel!
    var lblErrUUIDb4:UILabel!
    var lblErrUUIDb5:UILabel!

    var btnSet:UIButton!
    var btnReset:UIButton!
    var scrView:UIScrollView!
    var scan_uuid:UUID!
    
    var txtUUIDb1: UITextField!
    var txtUUIDb2: UITextField!
    var txtUUIDb3: UITextField!
    var txtUUIDb4: UITextField!
    var txtUUIDb5: UITextField!
    
    var uuid_valid: Bool = true

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // App Delegate を取得
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.scan_uuid = appDelegate.scan_uuid as UUID!

        // Controllerのタイトルを設定する.
        self.title = "監視UUID設定"
        
        // Viewの背景色を薄いグレー(#E6E6E6) に設定する。
        self.scrView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height) )
        self.scrView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.scrView)
        
        var offset:CGFloat = 0.0
        
        let lblDesc1:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc1.text = "監視対象ビーコン領域のUUID"
        lblDesc1.textAlignment = NSTextAlignment.left
        lblDesc1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc1.numberOfLines = 0
        lblDesc1.sizeToFit()
        scrView.addSubview(lblDesc1)
        offset += lblDesc1.frame.size.height + 10.0

        lblFullUUID = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblFullUUID.text = self.scan_uuid.uuidString
        lblFullUUID.font = UIFont.systemFont(ofSize: 14)
        lblFullUUID.textAlignment = NSTextAlignment.left
        lblFullUUID.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblFullUUID.numberOfLines = 0
        lblFullUUID.sizeToFit()
        scrView.addSubview(lblFullUUID)
        offset += lblFullUUID.frame.size.height + 15.0
        
        let lblDesc2:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc2.text = "UUIDの変更は、以下に入力して「設定」をタップしてください。"
        lblDesc2.textAlignment = NSTextAlignment.left
        lblDesc2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc2.numberOfLines = 0
        lblDesc2.sizeToFit()
        scrView.addSubview(lblDesc2)
        offset += lblDesc2.frame.size.height + 15.0

        let lblDesc3:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc3.text = "8桁"
        lblDesc3.textAlignment = NSTextAlignment.left
        lblDesc3.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblDesc3)
        
        txtUUIDb1 = UITextField(frame: CGRect(x: 50, y: offset, width: 160,height: 30))
        txtUUIDb1.text = "XXXXXXXX"
        txtUUIDb1.delegate = self
        txtUUIDb1.tag = 1
        txtUUIDb1.borderStyle = UITextBorderStyle.roundedRect
        txtUUIDb1.keyboardType = UIKeyboardType.asciiCapable
        scrView.addSubview(txtUUIDb1)
        
        offset += lblDesc3.frame.size.height + 5.0
        
        lblErrUUIDb1 = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrUUIDb1.text = "エラーメッセージ"
        lblErrUUIDb1.textColor = UIColor.red
        lblErrUUIDb1.textAlignment = NSTextAlignment.left
        lblErrUUIDb1.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrUUIDb1)

        offset += lblErrUUIDb1.frame.size.height + 15.0


        let lblDesc4:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc4.text = "4桁"
        lblDesc4.textAlignment = NSTextAlignment.left
        lblDesc4.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblDesc4)
        
        txtUUIDb2 = UITextField(frame: CGRect(x: 50, y: offset, width: 80,height: 30))
        txtUUIDb2.text = "XXXX"
        txtUUIDb2.delegate = self
        txtUUIDb2.tag = 2
        txtUUIDb2.borderStyle = UITextBorderStyle.roundedRect
        txtUUIDb2.keyboardType = UIKeyboardType.asciiCapable

        scrView.addSubview(txtUUIDb2)
        
        offset += lblDesc4.frame.size.height + 5.0

        lblErrUUIDb2 = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrUUIDb2.text = "エラーメッセージ"
        lblErrUUIDb2.textColor = UIColor.red
        lblErrUUIDb2.textAlignment = NSTextAlignment.left
        lblErrUUIDb2.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrUUIDb2)
        
        offset += lblErrUUIDb2.frame.size.height + 15.0


        let lblDesc5:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc5.text = "4桁"
        lblDesc5.textAlignment = NSTextAlignment.left
        lblDesc5.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblDesc5)

        txtUUIDb3 = UITextField(frame: CGRect(x: 50, y: offset, width: 80,height: 30))
        txtUUIDb3.text = "XXXX"
        txtUUIDb3.delegate = self
        txtUUIDb3.tag = 3
        txtUUIDb3.borderStyle = UITextBorderStyle.roundedRect
        txtUUIDb3.keyboardType = UIKeyboardType.asciiCapable

        scrView.addSubview(txtUUIDb3)
        
        offset += lblDesc5.frame.size.height + 5.0
        
        lblErrUUIDb3 = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrUUIDb3.text = "エラーメッセージ"
        lblErrUUIDb3.textColor = UIColor.red
        lblErrUUIDb3.textAlignment = NSTextAlignment.left
        lblErrUUIDb3.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrUUIDb3)
        
        offset += lblErrUUIDb3.frame.size.height + 15.0
        
        
        let lblDesc6:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc6.text = "4桁"
        lblDesc6.textAlignment = NSTextAlignment.left
        lblDesc6.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblDesc6)

        txtUUIDb4 = UITextField(frame: CGRect(x: 50, y: offset, width: 80,height: 30))
        txtUUIDb4.text = "XXXX"
        txtUUIDb4.delegate = self
        txtUUIDb4.tag = 4
        txtUUIDb4.borderStyle = UITextBorderStyle.roundedRect
        txtUUIDb4.keyboardType = UIKeyboardType.asciiCapable
        scrView.addSubview(txtUUIDb4)

        offset += lblDesc6.frame.size.height + 5.0
        
        lblErrUUIDb4 = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrUUIDb4.text = "エラーメッセージ"
        lblErrUUIDb4.textColor = UIColor.red
        lblErrUUIDb4.textAlignment = NSTextAlignment.left
        lblErrUUIDb4.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrUUIDb4)
        
        offset += lblErrUUIDb4.frame.size.height + 15.0

        let lblDesc7:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc7.text = "12桁"
        lblDesc7.textAlignment = NSTextAlignment.left
        lblDesc7.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblDesc7)
        
        txtUUIDb5 = UITextField(frame: CGRect(x: 50, y: offset, width: 240,height: 30))
        txtUUIDb5.text = "XXXXXXXXXXXX"
        txtUUIDb5.delegate = self
        txtUUIDb5.tag = 5
        txtUUIDb5.borderStyle = UITextBorderStyle.roundedRect
        txtUUIDb5.keyboardType = UIKeyboardType.asciiCapable
        scrView.addSubview(txtUUIDb5)
        
        offset += lblDesc7.frame.size.height + 5.0
        
        lblErrUUIDb5 = UILabel(frame: CGRect(x: 50,y: offset,width: self.view.frame.width - 60, height: 20 ))
        lblErrUUIDb5.text = "エラーメッセージ"
        lblErrUUIDb5.textColor = UIColor.red
        lblErrUUIDb5.textAlignment = NSTextAlignment.left
        lblErrUUIDb5.lineBreakMode = NSLineBreakMode.byWordWrapping
        scrView.addSubview(lblErrUUIDb5)
        
        offset += lblErrUUIDb5.frame.size.height + 15.0

        let lblDesc8:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc8.text = "各フィールドには、0〜9,A,B,C,D,E,Fが使用できます。"
        lblDesc8.textAlignment = NSTextAlignment.left
        lblDesc8.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc8.numberOfLines = 0
        lblDesc8.sizeToFit()

        scrView.addSubview(lblDesc8)
        
        offset += lblDesc8.frame.size.height + 15.0
        
        btnSet = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnSet.setTitle("設定", for: UIControlState())
        btnSet.backgroundColor = UIColor.gray
        btnSet.layer.masksToBounds = true
        btnSet.tag = 1
        btnSet.addTarget(self, action: #selector(InputUUIDViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnSet)
        
        offset += btnSet.frame.size.height + 15.0
        
        
        let lblDesc9:UILabel = UILabel(frame: CGRect(x: 10,y: offset,width: self.view.frame.width - 20, height: 20 ))
        lblDesc9.text = "初期値に戻す場合は、以下のボタンをタップしてください。"
        lblDesc9.textAlignment = NSTextAlignment.left
        lblDesc9.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblDesc9.numberOfLines = 0
        lblDesc9.sizeToFit()
        scrView.addSubview(lblDesc9)
        
        offset += lblDesc8.frame.size.height + 15.0
        
        btnReset = UIButton(frame: CGRect(x: 20,y: offset,width: self.view.frame.size.width - 40,height: 25.0))
        btnReset.setTitle("初期値に戻す", for: UIControlState())
        btnReset.backgroundColor = UIColor.gray
        btnReset.layer.masksToBounds = true
        btnReset.tag = 2
        btnReset.addTarget(self, action: #selector(InputUUIDViewController.onClickButton(_:)), for: .touchUpInside)
        scrView.addSubview(self.btnReset)
        
        offset += btnReset.frame.size.height + 15.0
        
        scrView.contentSize = CGSize(width: self.view.frame.width, height: offset + (self.view.frame.height / 2) )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InputMajorViewController.tapGesture(_:)))
        self.scrView.addGestureRecognizer(tap)


        refresh()
    }
    
    override func viewWillAppear( _ animated: Bool ) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 端末の向きがかわったらNotificationを呼ばす設定.
        NotificationCenter.default.addObserver(self, selector: #selector(InputUUIDViewController.onOrientationChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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
    internal func tapGesture(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    
    // 画面の再描画
    func refresh() {
        lblErrUUIDb1.text = ""
        lblErrUUIDb2.text = ""
        lblErrUUIDb3.text = ""
        lblErrUUIDb4.text = ""
        lblErrUUIDb5.text = ""
        
        lblFullUUID.text = self.scan_uuid.uuidString
        
        let wkStr:NSString = self.scan_uuid.uuidString as NSString

        let UUID_b1 = wkStr.substring(with: NSRange(location: 0, length: 8))
        let UUID_b2 = wkStr.substring(with: NSRange(location: 9, length: 4))
        let UUID_b3 = wkStr.substring(with: NSRange(location: 14, length: 4))
        let UUID_b4 = wkStr.substring(with: NSRange(location: 19, length: 4))
        let UUID_b5 = wkStr.substring(with: NSRange(location: 24, length: 12))
        
        txtUUIDb1.text = UUID_b1
        txtUUIDb2.text = UUID_b2
        txtUUIDb3.text = UUID_b3
        txtUUIDb4.text = UUID_b4
        txtUUIDb5.text = UUID_b5
        
    }
    
    
    /*
    ボタンイベント
    */
    @objc internal func onClickButton(_ sender: UIButton){

        
        if( sender.tag == 1 ) {
            
            // checkField()
            
            if( checkField() == false ) {
                showAlert("入力値にエラーがあります。")
                return
            }
            let b1:NSString = txtUUIDb1.text! as NSString
            let b2:NSString = txtUUIDb2.text! as NSString
            let b3:NSString = txtUUIDb3.text! as NSString
            let b4:NSString = txtUUIDb4.text! as NSString
            let b5:NSString = txtUUIDb5.text! as NSString
            let wkStr = b1.uppercased + "-" + b2.uppercased + "-" + b3.uppercased + "-" + b4.uppercased + "-" + b5.uppercased
            
            let wkUUID = UUID(uuidString: wkStr)
            
            self.scan_uuid = wkUUID
            appDelegate.scan_uuid = wkUUID
            appDelegate.Save()
            
            showAlert("UUIDを変更しました。")

            refresh()

        }


        if( sender.tag == 2 ) {
            
            appDelegate.scan_uuid = appDelegate.defaultUUID
            appDelegate.Save()
            
            showAlert("初期値に戻しました。")
            
            refresh()
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
        
        self.uuid_valid = false
        
        // 数字とA〜F　のチェック
        let valid = isValidUUID(textField.text!)
        let len = (textField.text! as NSString).length
        
        switch( textField.tag ) {
        case 1:
            lblErrUUIDb1.text = ""
            if( valid == false ) {
                lblErrUUIDb1.text = "0〜9,A,B,C,D,E,F以外は入力できません"
                return false
            }
            if( len != 8 ) {
                lblErrUUIDb1.text = "8桁入力してください"
                return false
            }
            break
        case 2:
            lblErrUUIDb2.text = ""
            if( valid == false ) {
                lblErrUUIDb2.text = "0〜9,A,B,C,D,E,F以外は入力できません"
                return false
            }
            if( len != 4 ) {
                lblErrUUIDb2.text = "4桁入力してください"
                return false
            }
            break
        case 3:
            lblErrUUIDb3.text = ""
            if( valid == false ) {
                lblErrUUIDb3.text = "0〜9,A,B,C,D,E,F以外は入力できません"
                return false
            }
            if( len != 4 ) {
                lblErrUUIDb3.text = "4桁入力してください"
                return false
            }
            break
        case 4:
            lblErrUUIDb4.text = ""
            if( valid == false ) {
                lblErrUUIDb4.text = "0〜9,A,B,C,D,E,F以外は入力できません"
                return false
            }
            if( len != 4 ) {
                lblErrUUIDb4.text = "4桁入力してください"
                return false
            }
            
            break
        case 5:
            lblErrUUIDb5.text = ""
            if( valid == false ) {
                lblErrUUIDb5.text = "0〜9,A,B,C,D,E,F以外は入力できません"
                return false
            }
            if( len != 12 ) {
                lblErrUUIDb5.text = "12桁入力してください"
                return false
            }
            
            break
        default: break
        }
        
        self.uuid_valid = true
        
        return true

    }
    
    func checkField() -> Bool{
        self.uuid_valid = false
        
        
        // 数字とA〜F　のチェック
        let valid1 = isValidUUID(txtUUIDb1.text!)
        let len1 = (txtUUIDb1.text! as NSString).length
        lblErrUUIDb1.text = ""
        if( valid1 == false ) {
            lblErrUUIDb1.text = "0〜9,A,B,C,D,E,F以外は入力できません"
            return false
        }
        if( len1 != 8 ) {
            lblErrUUIDb1.text = "8桁入力してください"
            return false
        }
        
        let valid2 = isValidUUID(txtUUIDb2.text!)
        let len2 = (txtUUIDb2.text! as NSString).length
        
        lblErrUUIDb2.text = ""
        if( valid2 == false ) {
            lblErrUUIDb2.text = "0〜9,A,B,C,D,E,F以外は入力できません"
            return false
        }
        if( len2 != 4 ) {
            lblErrUUIDb2.text = "4桁入力してください"
            return false
        }
        
        let valid3 = isValidUUID(txtUUIDb3.text!)
        let len3 = (txtUUIDb3.text! as NSString).length
        
        lblErrUUIDb3.text = ""
        if( valid3 == false ) {
            lblErrUUIDb3.text = "0〜9,A,B,C,D,E,F以外は入力できません"
            return false
        }
        if( len3 != 4 ) {
            lblErrUUIDb3.text = "4桁入力してください"
            return false
        }
        
        let valid4 = isValidUUID(txtUUIDb4.text!)
        let len4 = (txtUUIDb4.text! as NSString).length
        
        lblErrUUIDb4.text = ""
        if( valid4 == false ) {
            lblErrUUIDb4.text = "0〜9,A,B,C,D,E,F以外は入力できません"
            return false
        }
        if( len4 != 4 ) {
            lblErrUUIDb4.text = "4桁入力してください"
            return false
        }
        
        let valid5 = isValidUUID(txtUUIDb5.text!)
        let len5 = (txtUUIDb5.text! as NSString).length
        lblErrUUIDb5.text = ""
        if( valid5 == false ) {
            lblErrUUIDb5.text = "0〜9,A,B,C,D,E,F以外は入力できません"
            return false
        }
        if( len5 != 12 ) {
            lblErrUUIDb5.text = "12桁入力してください"
            return false
        }
        
        self.uuid_valid = true
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func isValidUUID(_ str: String) -> Bool {
        let pattern = "^[a-fA-F0-9]+$"
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
