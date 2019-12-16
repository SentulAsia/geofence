//
//  MapPresenter.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol MapPresentationLogic {
    func presentFetchFromLocalDataStore(with response: MapModels.FetchFromLocalDataStore.Response)
    func presentFetchWifiSSID(with response: MapModels.FetchWifiSSID.Response)
    func presentPerformChangeRadiusValue(with response: MapModels.PerformChangeRadiusValue.Response)
    func presentPerformAddGeofence(with response: MapModels.PerformAddGeofence.Response)
}

class MapPresenter: MapPresentationLogic {

    // MARK: - Properties

    weak var viewController: MapDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: MapModels.FetchFromLocalDataStore.Response) {
        let geofenceButtonText = "Add Geofence"
        let viewModel = MapModels.FetchFromLocalDataStore.ViewModel(geofenceButtonText: geofenceButtonText)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch Wifi SSID

    func presentFetchWifiSSID(with response: MapModels.FetchWifiSSID.Response) {
        let viewModel = MapModels.FetchWifiSSID.ViewModel(wifiSSID: response.wifiSSID)
        viewController?.displayFetchWifiSSID(with: viewModel)
    }

    // MARK: - Use Case - Change Radius Value

    func presentPerformChangeRadiusValue(with response: MapModels.PerformChangeRadiusValue.Response) {
        let radiusLabelText = "Radius: \(response.radiusValue)m"
        let viewModel = MapModels.PerformChangeRadiusValue.ViewModel(radiusLabelText: radiusLabelText)
        viewController?.displayPerformChangeRadiusValue(with: viewModel)
    }

    // MARK: - Use Case - Add Geofence

    func presentPerformAddGeofence(with response: MapModels.PerformAddGeofence.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .invalidRadius:
                responseError?.message = "Please enter radius between 100m to 2,128,000m."

            case .invalidCoordinate:
                responseError?.message = "Invalid coordinate entered."
            }
        }

        let viewModel = MapModels.PerformAddGeofence.ViewModel(error: responseError)
        viewController?.displayPerformAddGeofence(with: viewModel)
    }
}
