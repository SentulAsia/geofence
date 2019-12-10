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
    func fetchFromRemoteDataStore(with request: MapModels.FetchFromRemoteDataStore.Request)
    func performMap(with request: MapModels.PerformMap.Request)
}

protocol MapDataStore {
    var exampleVariable: String? { get set }
}

class MapInteractor: MapBusinessLogic, MapDataStore {

    // MARK: - Properties

    var worker: MapWorker? = MapWorker()
    var presenter: MapPresentationLogic?
    var exampleVariable: String?

    // MARK: - Use Case - Fetch From Local DataStore

    func fetchFromLocalDataStore(with request: MapModels.FetchFromLocalDataStore.Request) {
        let response = MapModels.FetchFromLocalDataStore.Response()
        presenter?.presentFetchFromLocalDataStore(with: response)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func fetchFromRemoteDataStore(with request: MapModels.FetchFromRemoteDataStore.Request) {
        worker?.fetchFromRemoteDataStore(completion: {
            [weak self] code in
            let response = MapModels.FetchFromRemoteDataStore.Response(exampleVariable: code)
            self?.presenter?.presentFetchFromRemoteDataStore(with: response)
        })
    }

    // MARK: - Use Case - Map

    func performMap(with request: MapModels.PerformMap.Request) {
        worker?.validate(exampleVariable: request.exampleVariable)

        if let error = worker?.error {
            let response = MapModels.PerformMap.Response(error: error)
            presenter?.presentPerformMap(with: response)
            return
        }

        worker?.performMap(completion: {
            [weak self, request] isSuccessful, error in

            if isSuccessful {
                // do something on success
                let goodExample = request.exampleVariable ?? ""
                self?.exampleVariable = goodExample
            }

            let response = MapModels.PerformMap.Response(error: error)
            self?.presenter?.presentPerformMap(with: response)
        })
    }
}
