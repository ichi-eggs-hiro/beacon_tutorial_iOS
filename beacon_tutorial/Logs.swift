//
//  Logs.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/19.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import Foundation
import CoreLocation

class Logs {
    //
    var arLog : NSMutableArray!
    
    func Clear() {
        arLog = NSMutableArray()
    }
    
    func Add( uuid:NSUUID, major:NSNumber, minor:NSNumber, lat:CLLocationDegrees, lon:CLLocationDegrees, d:NSDate ) {

        let l : log = log(uuid: uuid, major: major, minor: minor, lat: lat, lon: lon, dt: d)
        arLog.addObject(l)
    }
    
    func CreateCSV() -> String {
        if( arLog.count == 0 ) {
            return "LOGDATA NOTHING"
        }
        
        var strCSV : String = ""
        
        let RFC3339DateFormatter = NSDateFormatter()
        RFC3339DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)

        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") // ロケールの設定
        dateFormatter.timeStyle = .LongStyle
        dateFormatter.dateStyle = .LongStyle
        
        
        for i in 0  ..< arLog.count  {
            let l = arLog[i] as! log
            
            let dt : String = RFC3339DateFormatter.stringFromDate(l.date)
            
            strCSV += dt
            strCSV += ","
            strCSV += l.UUID.UUIDString
            strCSV += ","
            strCSV += l.major.stringValue
            strCSV += ","
            strCSV += l.minor.stringValue
            strCSV += ","
            strCSV += "\(l.latitude)"
            strCSV += ","
            strCSV += "\(l.longitude)"
            strCSV += "\n"
        }
        
        return strCSV;
    }
    
}
