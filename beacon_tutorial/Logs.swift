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
    
    func Add( _ uuid:UUID, major:NSNumber, minor:NSNumber, lat:CLLocationDegrees, lon:CLLocationDegrees, d:Date ) {

        let l : log = log(uuid: uuid, major: major, minor: minor, lat: lat, lon: lon, dt: d)
        arLog.add(l)
    }
    
    func CreateCSV() -> String {
        if( arLog.count == 0 ) {
            return "LOGDATA NOTHING"
        }
        
        var strCSV : String = ""
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US") // ロケールの設定
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
        
        
        for i in 0  ..< arLog.count  {
            let l = arLog[i] as! log
            
            let dt : String = RFC3339DateFormatter.string(from: l.date as Date)
            
            strCSV += dt
            strCSV += ","
            strCSV += l.UUID.uuidString
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
