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
}

protocol StatusDataStore {
}

class StatusInteractor: StatusBusinessLogic, StatusDataStore {

    // MARK: - Properties

    var worker: StatusWorker? = StatusWorker()
    var presenter: StatusPresentationLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: StatusModels.FetchFromLocalDataStore.Request) {
        let response = StatusModels.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch Geofence Status

    func fetchGeofenceStatus(with request: StatusModels.FetchGeofenceStatus.Request) {
        worker?.fetchGeofenceStatus(completion: {
            [weak self] status, error in
            let response = StatusModels.FetchGeofenceStatus.Response(status: status, error: error)
            self?.presenter?.presentFetchGeofenceStatus(with: response)
        })
    }
}
