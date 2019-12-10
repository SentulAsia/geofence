//
//  GeofenceListWorker.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

class GeofenceListWorker {

    // MARK: - Properties

    typealias ErrorType = GeofenceListModels.GeofenceListErrorType
    var error: GeofenceListModels.Error<ErrorType>?

    // MARK: - Methods

    // MARK: Fetch From Remote DataStore

    func fetchFromRemoteDataStore(completion: (_ code: String) -> Void) {
        // fetch something from backend,
        // and return the values here
        let code = "0000"
        completion(code)
    }

    // MARK: Validation

    func validate(exampleVariable: String?) {
        if exampleVariable?.isEmpty == false {
            error = nil
        }
        else {
            error = GeofenceListModels.Error<ErrorType>(type: .emptyExampleVariable)
        }
    }

    // MARK: Track Analytics

    func trackAnalytics(event: GeofenceListModels.AnalyticsEvents) {
        switch event {
        case .screenView:
            // call analytics library/wrapper here to track analytics
            break
        }
    }

    // MARK: Perform GeofenceList

    func performGeofenceList(completion: @escaping (Bool, GeofenceListModels.Error<ErrorType>?) -> Void) {
        let isSuccessful = true
        let error: GeofenceListModels.Error<ErrorType>? = nil

        completion(isSuccessful, error)
    }
}
