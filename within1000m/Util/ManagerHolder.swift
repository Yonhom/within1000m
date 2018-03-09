//
//  ManagerHolder.swift
//  within1000m
//
//  Created by 徐永宏 on 2018/3/9.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit
import CoreLocation

class ManagerHolder: NSObject {

    let locManager = CLLocationManager()
    var doThisWhenAuthorized: (() -> ())?
    
    // the then code block is ran after the location access is decided
    func checkForLocationAccess(
        always: Bool = false,
        andThen f: (() -> ())? = nil) {
        
        // no services? try to get alert
        guard CLLocationManager.locationServicesEnabled() else {
            // this will give a alert for opening the location service in the settings
            self.locManager.startUpdatingLocation()
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse:
            if always {
                self.doThisWhenAuthorized = f
                self.locManager.requestAlwaysAuthorization()
            } else {
                f?()
            }
        case .authorizedAlways:
            f?()
        case .notDetermined:
            self.doThisWhenAuthorized = f
            always ? locManager.requestAlwaysAuthorization() : locManager.requestWhenInUseAuthorization()
        case .restricted:
            // do nothing
            break
        case .denied:
            // do nothing, or beg the user to authorize us in Settings
            break
        
        }
        
    }
}
