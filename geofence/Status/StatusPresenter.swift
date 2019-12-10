//
//  StatusPresenter.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol StatusPresentationLogic {
    func presentFetchFromLocalDataStore(with response: StatusModels.FetchFromLocalDataStore.Response)
    func presentFetchGeofenceStatus(with response: StatusModels.FetchGeofenceStatus.Response)
}

class StatusPresenter: StatusPresentationLogic {

    // MARK: - Properties

    weak var viewController: StatusDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: StatusModels.FetchFromLocalDataStore.Response) {
        let text = "Unknown"
        let viewModel = StatusModels.FetchFromLocalDataStore.ViewModel(geofenceStatus: text)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch Geofence Status

    func presentFetchGeofenceStatus(with response: StatusModels.FetchGeofenceStatus.Response) {
        let status = response.status ?? .unknown
        let text = status.rawValue
        let viewModel = StatusModels.FetchGeofenceStatus.ViewModel(geofenceStatus: text)
        viewController?.displayFetchGeofenceStatus(with: viewModel)
    }
}
