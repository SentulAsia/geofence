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
    func presentFetchFromRemoteDataStore(with response: MapModels.FetchFromRemoteDataStore.Response)
    func presentPerformMap(with response: MapModels.PerformMap.Response)
}

class MapPresenter: MapPresentationLogic {

    // MARK: - Properties

    weak var viewController: MapDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: MapModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localised text."
        let viewModel = MapModels.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        viewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: MapModels.FetchFromRemoteDataStore.Response) {
        let code = response.exampleVariable
        var exampleText: String

        switch code {
        case "0000":
            exampleText = "Success!"

        default:
            exampleText = "Oops."
        }

        let viewModel = MapModels.FetchFromRemoteDataStore.ViewModel(exampleVariable: exampleText)
        viewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Map

    func presentPerformMap(with response: MapModels.PerformMap.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localised empty/nil error message."

            case .apiError:
                responseError?.message = "Localised api error message."
            }
        }

        let viewModel = MapModels.PerformMap.ViewModel(error: responseError)
        viewController?.displayPerformMap(with: viewModel)
    }
}
