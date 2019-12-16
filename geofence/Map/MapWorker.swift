//
//  MapWorker.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit
import CoreLocation

class MapWorker {

    // MARK: - Properties

    typealias ErrorType = MapModels.MapErrorType
    var error: MapModels.Error<ErrorType>?

    // MARK: - Methods

    // MARK: Validation

    func validate(coordinate: CLLocationCoordinate2D, radiusValue: Int) {
        // TODO: validate coordinate
        if radiusValue < 100 || radiusValue > 2128000 {
            error = MapModels.Error<ErrorType>(type: .invalidRadius)
        } else {
            error = nil
        }
    }

    // MARK: Perform Add Geofence

    func performAddGeofence(coordinate: CLLocationCoordinate2D, radiusValue: Int, completion: @escaping (Bool, MapModels.Error<ErrorType>?) -> Void) {

        DataStore.shared.latitude = coordinate.latitude
        DataStore.shared.longitude = coordinate.longitude
        DataStore.shared.radius = radiusValue

        let isSuccessful = true
        let error: MapModels.Error<ErrorType>? = nil

        completion(isSuccessful, error)
    }
}
