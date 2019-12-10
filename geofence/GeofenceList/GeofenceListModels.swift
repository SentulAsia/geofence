//
//  GeofenceListModels.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

enum GeofenceListModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var exampleTranslation: String?
        }
    }

    enum FetchFromRemoteDataStore {
        struct Request {
        }

        struct Response {
            var exampleVariable: String?
        }

        struct ViewModel {
            var exampleVariable: String?
        }
    }

    enum TrackAnalytics {
        struct Request {
            var event: AnalyticsEvents
        }

        struct Response {
        }

        struct ViewModel {
        }
    }

    enum PerformGeofenceList {
        struct Request {
            var exampleVariable: String?
        }

        struct Response {
            var error: Error<GeofenceListErrorType>?
        }

        struct ViewModel {
            var error: Error<GeofenceListErrorType>?
        }
    }

    // MARK: - View Models

    enum AnalyticsEvents {
        case screenView
    }

    enum GeofenceListErrorType {
        case emptyExampleVariable, apiError
    }

    struct Error<T> {
        var type: T
        var message: String?

        init(type: T) {
            self.type = type
        }
    }
}
