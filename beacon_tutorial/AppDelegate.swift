//
//  AppDelegate.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2015/12/05.
//  Copyright © 2015年 Smartlinks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var NavigationController: UINavigationController?
    var homeViewController: HomeViewController!
    
    // BeaconのIdentifierを設定.
    let identifierStr:NSString = "TownBeacon"
    let defaultUUID:NSUUID? = NSUUID(UUIDString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
    
    var scan_uuid:NSUUID?
    var scan_major:NSNumber = -1
    var scan_minor:NSNumber = -1
    
    var logData:Logs = Logs()
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.scan_uuid = defaultUUID
        self.Load()
        
        self.logData.Clear()
        
        // ViewControllerを生成する.
        self.homeViewController = HomeViewController()
        
        // Navication Controllerを生成する.
        self.NavigationController = UINavigationController(rootViewController: homeViewController)
        
        // UIWindowを生成する.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // rootViewControllerにNatigationControllerを設定する.
        self.window?.rootViewController = NavigationController
        
        self.window?.makeKeyAndVisible()
        
        
        
        if(application.respondsToSelector(#selector(UIApplication.registerUserNotificationSettings(_:)))) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Sound],
                    categories: nil
                )
            )

        }
        
        return true
    }
    
    func Load() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if((defaults.objectForKey("SCAN_UUID")) != nil){
            self.scan_uuid = NSUUID(UUIDString: (defaults.objectForKey("SCAN_UUID") as? String)! )
        }
        if((defaults.objectForKey("SCAN_MAJOR")) != nil){
            self.scan_major = (defaults.objectForKey("SCAN_MAJOR") as? NSNumber)!
        }
        if((defaults.objectForKey("SCAN_MINOR")) != nil){
            self.scan_minor = (defaults.objectForKey("SCAN_MINOR") as? NSNumber)!
        }
    }
    
    func Save() {
        //NSUserDefaultsのインスタンスを生成
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //"NAME"というキーで配列namesを保存
        defaults.setObject(self.scan_uuid?.UUIDString, forKey:"SCAN_UUID")
        defaults.setObject(self.scan_major, forKey:"SCAN_MAJOR")
        defaults.setObject(self.scan_minor, forKey:"SCAN_MINOR")
        
        // シンクロを入れないとうまく動作しないときがあります
        defaults.synchronize()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

