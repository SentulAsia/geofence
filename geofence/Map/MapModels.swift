//
//  MapModels.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit
import CoreLocation

enum MapModels {

    // MARK: - Use Cases

    enum FetchFromLocalDataStore {
        struct Request {
        }

        struct Response {
        }

        struct ViewModel {
            var geofenceButtonText: String
        }
    }

    enum FetchWifiSSID {
        struct Request {
        }

        struct Response {
            var wifiSSID: String?
        }

        struct ViewModel {
            var wifiSSID: String?
        }
    }

    enum PerformChangeRadiusValue {
        struct Request {
            var radiusValue: Int
        }

        struct Response {
            var radiusValue: Int
        }

        struct ViewModel {
            var radiusLabelText: String
        }
    }

    enum PerformAddGeofence {
        struct Request {
            var coordinate: CLLocationCoordinate2D
            var radiusValue: Int
        }

        struct Response {
            var error: Error<MapErrorType>?
        }

        struct ViewModel {
            var error: Error<MapErrorType>?
        }
    }

    // MARK: - View Models

    enum MapErrorType {
        case invalidRadius, invalidCoordinate
    }

    struct Error<T> {
        var type: T
        var message: String?

        init(type: T) {
            self.type = type
        }
    }
}
