//
//  MapWorker.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

class MapWorker {

    // MARK: - Properties

    typealias ErrorType = MapModels.MapErrorType
    var error: MapModels.Error<ErrorType>?

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
            error = MapModels.Error<ErrorType>(type: .emptyExampleVariable)
        }
    }

    // MARK: Track Analytics

    func trackAnalytics(event: MapModels.AnalyticsEvents) {
        switch event {
        case .screenView:
            // call analytics library/wrapper here to track analytics
            break
        }
    }

    // MARK: Perform Map

    func performMap(completion: @escaping (Bool, MapModels.Error<ErrorType>?) -> Void) {
        let isSuccessful = true
        let error: MapModels.Error<ErrorType>? = nil

        completion(isSuccessful, error)
    }
}
