//
//  MapInteractor.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol MapBusinessLogic {
    func fetchFromLocalDataStore(with request: MapModels.FetchFromLocalDataStore.Request)
    func fetchWifiSSID(with request: MapModels.FetchWifiSSID.Request)
    func performChangeRadiusValue(with request: MapModels.PerformChangeRadiusValue.Request)
    func performAddGeofence(with request: MapModels.PerformAddGeofence.Request)
}

protocol MapDataStore {
}

class MapInteractor: MapBusinessLogic, MapDataStore {

    // MARK: - Properties

    var worker: MapWorker? = MapWorker()
    var presenter: MapPresentationLogic?
    var wifiManager: WifiManager? = WifiManager()

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: MapModels.FetchFromLocalDataStore.Request) {
        let response = MapModels.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch Wifi SSID

    func fetchWifiSSID(with request: MapModels.FetchWifiSSID.Request) {
        wifiManager?.fetchWifiSSID(completion: {
            [weak self] (wifiSSID) in
            DataStore.shared.wifiSSID = wifiSSID
            let response = MapModels.FetchWifiSSID.Response(wifiSSID: wifiSSID)
            self?.presenter?.presentFetchWifiSSID(with: response)
        })
    }

    // MARK: - Use Case - Change Radius Value

    func performChangeRadiusValue(with request: MapModels.PerformChangeRadiusValue.Request) {
        let response = MapModels.PerformChangeRadiusValue.Response(radiusValue: request.radiusValue)
        presenter?.presentPerformChangeRadiusValue(with: response)
    }

    // MARK: - Use Case - Add Geofence

    func performAddGeofence(with request: MapModels.PerformAddGeofence.Request) {
        worker?.validate(coordinate: request.coordinate, radiusValue: request.radiusValue)

        if let error = worker?.error {
            let response = MapModels.PerformAddGeofence.Response(error: error)
            presenter?.presentPerformAddGeofence(with: response)
            return
        }

        worker?.performAddGeofence(coordinate: request.coordinate, radiusValue: request.radiusValue, completion: {
            [weak self] isSuccessful, error in

            let response = MapModels.PerformAddGeofence.Response(error: error)
            self?.presenter?.presentPerformAddGeofence(with: response)
        })
    }
}
