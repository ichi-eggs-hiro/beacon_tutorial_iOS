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
    let defaultUUID:UUID? = UUID(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
    
    var scan_uuid:UUID?
    var scan_major:NSNumber = -1
    var scan_minor:NSNumber = -1
    
    var logData:Logs = Logs()
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.scan_uuid = defaultUUID
        self.Load()
        
        self.logData.Clear()
        
        // ViewControllerを生成する.
        self.homeViewController = HomeViewController()
        
        // Navication Controllerを生成する.
        self.NavigationController = UINavigationController(rootViewController: homeViewController)
        
        // UIWindowを生成する.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // rootViewControllerにNatigationControllerを設定する.
        self.window?.rootViewController = NavigationController
        
        self.window?.makeKeyAndVisible()
        
        
        
        if(application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    types: [UIUserNotificationType.alert, UIUserNotificationType.sound],
                    categories: nil
                )
            )

        }
        
        return true
    }
    
    func Load() {
        
        let defaults = UserDefaults.standard
        
        if((defaults.object(forKey: "SCAN_UUID")) != nil){
            self.scan_uuid = UUID(uuidString: (defaults.object(forKey: "SCAN_UUID") as? String)! )
        }
        if((defaults.object(forKey: "SCAN_MAJOR")) != nil){
            self.scan_major = (defaults.object(forKey: "SCAN_MAJOR") as? NSNumber)!
        }
        if((defaults.object(forKey: "SCAN_MINOR")) != nil){
            self.scan_minor = (defaults.object(forKey: "SCAN_MINOR") as? NSNumber)!
        }
    }
    
    func Save() {
        //NSUserDefaultsのインスタンスを生成
        let defaults = UserDefaults.standard
        
        //"NAME"というキーで配列namesを保存
        defaults.set(self.scan_uuid?.uuidString, forKey:"SCAN_UUID")
        defaults.set(self.scan_major, forKey:"SCAN_MAJOR")
        defaults.set(self.scan_minor, forKey:"SCAN_MINOR")
        
        // シンクロを入れないとうまく動作しないときがあります
        defaults.synchronize()
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

