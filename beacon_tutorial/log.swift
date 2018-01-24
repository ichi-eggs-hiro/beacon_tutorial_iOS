//
//  log.swift
//  beacon_tutorial
//
//  Created by 市川 博康 on 2016/02/19.
//  Copyright © 2016年 Smartlinks. All rights reserved.
//

import CoreLocation


class log {
    var UUID:Foundation.UUID
    var major:NSNumber
    var minor:NSNumber
    var latitude:CLLocationDegrees
    var longitude:CLLocationDegrees
    var date:Date
    
    init(uuid:Foundation.UUID,major:NSNumber,minor:NSNumber,lat:CLLocationDegrees,lon:CLLocationDegrees,dt:Date ) {
        self.UUID = uuid
        self.major = major
        self.minor = minor
        self.latitude = lat
        self.longitude = lon
        self.date = dt
    }
}
