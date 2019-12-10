//
//  GeofenceWorker.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import CoreLocation

class GeofenceWorker: NSObject {
    let locationManager = CLLocationManager()

    override init() {
        super.init()

//        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
}

//extension GeofenceWorker: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        <#code#>
//    }
//
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        <#code#>
//    }
//}
