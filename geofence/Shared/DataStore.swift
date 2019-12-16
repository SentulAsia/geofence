//
//  DataStore.swift
//  geofence
//
//  Created by Zaid Said on 11/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import Foundation

struct DataStore {

    static var shared = DataStore()

    struct Keys {
        static let Latitude = "kLatitude"
        static let Longitude = "kLongitude"
        static let Radius = "kRadius"
        static let WifiSSID = "kWifiSSID"
    }

    var latitude: Double? {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Latitude) as? Double
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Latitude)
            UserDefaults.standard.synchronize()
        }
    }

    var longitude: Double? {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Longitude) as? Double
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Longitude)
            UserDefaults.standard.synchronize()
        }
    }

    var radius: Int? {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Radius) as? Int
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Radius)
            UserDefaults.standard.synchronize()
        }
    }

    var wifiSSID: String? {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.WifiSSID) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.WifiSSID)
            UserDefaults.standard.synchronize()
        }
    }
}
