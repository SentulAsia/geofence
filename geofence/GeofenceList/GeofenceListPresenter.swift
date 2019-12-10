//
//  GeofenceListPresenter.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol GeofenceListPresentationLogic {
    func presentFetchFromLocalDataStore(with response: GeofenceListModels.FetchFromLocalDataStore.Response)
    func presentFetchFromRemoteDataStore(with response: GeofenceListModels.FetchFromRemoteDataStore.Response)
    func presentTrackAnalytics(with response: GeofenceListModels.TrackAnalytics.Response)
    func presentPerformGeofenceList(with response: GeofenceListModels.PerformGeofenceList.Response)
}

class GeofenceListPresenter: GeofenceListPresentationLogic {

    // MARK: - Properties

    weak var tableViewController: GeofenceListDisplayLogic?

    // MARK: - Use Case - Fetch From Local DataStore

    func presentFetchFromLocalDataStore(with response: GeofenceListModels.FetchFromLocalDataStore.Response) {
        let translation = "Some localised text."
        let viewModel = GeofenceListModels.FetchFromLocalDataStore.ViewModel(exampleTranslation: translation)
        tableViewController?.displayFetchFromLocalDataStore(with: viewModel)
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    func presentFetchFromRemoteDataStore(with response: GeofenceListModels.FetchFromRemoteDataStore.Response) {
        let code = response.exampleVariable
        var exampleText: String

        switch code {
        case "0000":
            exampleText = "Success!"

        default:
            exampleText = "Oops."
        }

        let viewModel = GeofenceListModels.FetchFromRemoteDataStore.ViewModel(exampleVariable: exampleText)
        tableViewController?.displayFetchFromRemoteDataStore(with: viewModel)
    }

    // MARK: - Use Case - Track Analytics

    func presentTrackAnalytics(with response: GeofenceListModels.TrackAnalytics.Response) {
        let viewModel = GeofenceListModels.TrackAnalytics.ViewModel()
        tableViewController?.displayTrackAnalytics(with: viewModel)
    }

    // MARK: - Use Case - GeofenceList

    func presentPerformGeofenceList(with response: GeofenceListModels.PerformGeofenceList.Response) {
        var responseError = response.error

        if let error = responseError {
            switch error.type {
            case .emptyExampleVariable:
                responseError?.message = "Localised empty/nil error message."

            case .apiError:
                responseError?.message = "Localised api error message."
            }
        }

        let viewModel = GeofenceListModels.PerformGeofenceList.ViewModel(error: responseError)
        tableViewController?.displayPerformGeofenceList(with: viewModel)
    }
}
