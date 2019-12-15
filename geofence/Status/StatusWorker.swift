//
//  StatusWorker.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit
import CoreLocation

class StatusWorker: NSObject {

    // MARK: - Properties

    typealias ErrorType = StatusModels.StatusErrorType
    var error: StatusModels.Error<ErrorType>?
    let locationManager = CLLocationManager()
    var status = StatusModels.GeofenceStatus.unknown

    // MARK: - Methods

    // MARK: Fetch Geofence Status

    func fetchGeofenceStatus(completion: (_ status: StatusModels.GeofenceStatus) -> Void) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        completion(status)
    }
}

extension StatusWorker: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        status = .inside
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        status = .outside
    }
}
