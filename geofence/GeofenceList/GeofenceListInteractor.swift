//
//  GeofenceListInteractor.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol GeofenceListBusinessLogic {
    func fetchFromLocalDataStore(with request: GeofenceListModels.FetchFromLocalDataStore.Request)
    func fetchFromRemoteDataStore(with request: GeofenceListModels.FetchFromRemoteDataStore.Request)
    func trackAnalytics(with request: GeofenceListModels.TrackAnalytics.Request)
    func performGeofenceList(with request: GeofenceListModels.PerformGeofenceList.Request)
}

protocol GeofenceListDataStore {
    var exampleVariable: String? { get set }
}

class GeofenceListInteractor: GeofenceListBusinessLogic, GeofenceListDataStore {

    // MARK: - Properties

    var worker: GeofenceListWorker? = GeofenceListWorker()
    var presenter: GeofenceListPresentationLogic?
    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: GeofenceListModels.FetchFromLocalDataStore.Request) {
        let response = GeofenceListModels.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: GeofenceListModels.FetchFromRemoteDataStore.Request) {
        worker?.fetchFromRemoteDataStore(completion: {
            [weak self] code in
            let response = GeofenceListModels.FetchFromRemoteDataStore.Response(exampleVariable: code)
            self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        })
    }

    // MARK: - Use Case - Track Analytics

    func trackAnalytics(with request: GeofenceListModels.TrackAnalytics.Request) {
        worker?.trackAnalytics(event: request.event)

        let response = GeofenceListModels.TrackAnalytics.Response()
        presenter?.presentTrackAnalytics(with: response)
    }

    // MARK: - Use Case - GeofenceList

    func performGeofenceList(with request: GeofenceListModels.PerformGeofenceList.Request) {
        worker?.validate(exampleVariable: request.exampleVariable)

        if let error = worker?.error {
            let response = GeofenceListModels.PerformGeofenceList.Response(error: error)
            presenter?.presentPerformGeofenceList(with: response)
            return
        }

        worker?.performGeofenceList(completion: {
            [weak self, request] isSuccessful, error in

            if isSuccessful {
                // do something on success
                let goodExample = request.exampleVariable ?? ""
                self?.exampleVariable = goodExample
            }

            let response = GeofenceListModels.PerformGeofenceList.Response(error: error)
            self?.presenter?.presentPerformGeofenceList(with: response)
        })
    }
}
