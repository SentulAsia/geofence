//
//  StatusInteractor.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol StatusBusinessLogic {
    func fetchFromLocalDataStore(with request: StatusModels.FetchFromLocalDataStore.Request)
    func fetchGeofenceStatus(with request: StatusModels.FetchGeofenceStatus.Request)
    func fetchWifiSSID(with request: StatusModels.FetchWifiSSID.Request)
}

protocol StatusDataStore {
    var status: StatusModels.GeofenceStatus? { get set }
}

class StatusInteractor: StatusBusinessLogic, StatusDataStore {

    // MARK: - Properties

    var worker: StatusWorker? = StatusWorker()
    var presenter: StatusPresentationLogic?
    var wifiManager: WifiManager? = WifiManager()
    var status: StatusModels.GeofenceStatus?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: StatusModels.FetchFromLocalDataStore.Request) {
        let response = StatusModels.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch Geofence Status

    func fetchGeofenceStatus(with request: StatusModels.FetchGeofenceStatus.Request) {
        worker?.fetchGeofenceStatus(completion: {
            [weak self] status, error in
            self?.status = status
            let response = StatusModels.FetchGeofenceStatus.Response(status: status, error: error)
            self?.presenter?.presentFetchGeofenceStatus(with: response)
        })
    }

    // MARK: - Use Case - Fetch Wifi SSID

    func fetchWifiSSID(with request: StatusModels.FetchWifiSSID.Request) {
        wifiManager?.fetchWifiSSID(completion: {
            [weak self] (wifiSSID) in
            let wifiEnabled = DataStore.shared.wifiSSID == wifiSSID
            let response = StatusModels.FetchWifiSSID.Response(wifiEnabled: wifiEnabled, status: self?.status)
            self?.presenter?.presentFetchWifiSSID(with: response)
        })
    }
}
