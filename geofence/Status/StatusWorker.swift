//
//  StatusWorker.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

class StatusWorker {

    // MARK: - Properties

    typealias ErrorType = StatusModels.StatusErrorType
    var error: StatusModels.Error<ErrorType>?

    // MARK: - Methods

    // MARK: Fetch Geofence Status

    func fetchGeofenceStatus(completion: (_ status: StatusModels.GeofenceStatus) -> Void) {
        // TODO: get actual geofence status
        let status = StatusModels.GeofenceStatus.outside
        completion(status)
    }

    // MARK: Validation

    func validate(exampleVariable: String?) {
        if exampleVariable?.isEmpty == false {
            error = nil
        }
        else {
            error = StatusModels.Error<ErrorType>(type: .emptyExampleVariable)
        }
    }

    // MARK: Perform Status

    func performStatus(completion: @escaping (Bool, StatusModels.Error<ErrorType>?) -> Void) {
        let isSuccessful = true
        let error: StatusModels.Error<ErrorType>? = nil

        completion(isSuccessful, error)
    }
}
