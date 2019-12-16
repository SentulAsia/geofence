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
    func presentFetchWifiSSID(with response: StatusModels.FetchWifiSSID.Response)
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
        var responseError = response.error
        let status = response.status ?? .unknown
        let geofenceStatus = status.rawValue

        if let error = responseError {
            switch error.type {
            case .locationNotAuthorized:
                responseError?.message = "Please enable always location permission in the settings."

            case .coordinateNotAvailable:
                responseError?.message = ""
            }
        }
        
        let viewModel = StatusModels.FetchGeofenceStatus.ViewModel(status: response.status, geofenceStatus: geofenceStatus, error: response.error)
        viewController?.displayFetchGeofenceStatus(with: viewModel)
    }

    // MARK: - Use Case - Fetch Wifi SSID

    func presentFetchWifiSSID(with response: StatusModels.FetchWifiSSID.Response) {
        let geofenceStatus = response.wifiEnabled ? StatusModels.GeofenceStatus.inside.rawValue : response.status?.rawValue

        let viewModel = StatusModels.FetchWifiSSID.ViewModel(wifiEnabled: response.wifiEnabled, geofenceStatus: geofenceStatus)
        viewController?.displayFetchWifiSSID(with: viewModel)
    }
}
