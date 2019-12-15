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

    func fetchGeofenceStatus(completion: @escaping (StatusModels.GeofenceStatus, StatusModels.Error<ErrorType>?) -> Void) {
        var error: StatusModels.Error<ErrorType>?

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            error = StatusModels.Error<ErrorType>(type: .locationNotAuthorized)
        }

        if error == nil {
            if let latitude = DataStore.shared.latitude, let longitude = DataStore.shared.longitude, let radius = DataStore.shared.radius?.doubleValue {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let region = CLCircularRegion(center: coordinate, radius: radius, identifier: Constants.geofenceIdentifier)
                locationManager.startMonitoring(for: region)
            }
            else {
                error = StatusModels.Error<ErrorType>(type: .coordinateNotAvailable)
            }
        }

        completion(status, error)
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
