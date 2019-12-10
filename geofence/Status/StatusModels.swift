//
//  StatusModels.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

enum StatusModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var geofenceStatus: String?
        }
    }

    enum FetchGeofenceStatus {
        struct Request {
        }

        struct Response {
            var status: GeofenceStatus?
        }

        struct ViewModel {
            var geofenceStatus: String?
        }
    }

    // MARK: - View Models

    enum GeofenceStatus: String {
        case inside = "Inside"
        case outside = "Outside"
        case unknown = "Unknown"
    }

    enum StatusErrorType {
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
