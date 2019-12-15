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
        static let Coordinate1 = "kCoordinate1"
        static let Coordinate2 = "kCoordinate2"
        static let Radius = "kRadius"
    }

    var coordinate1: Double {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Coordinate1) as! Double
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Coordinate1)
            UserDefaults.standard.synchronize()
        }
    }

    var coordinate2: Double {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Coordinate2) as! Double
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Coordinate2)
            UserDefaults.standard.synchronize()
        }
    }

    var radius: Int {
        get {
            UserDefaults.standard.synchronize()
            return UserDefaults.standard.object(forKey: Keys.Radius) as! Int
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.Radius)
            UserDefaults.standard.synchronize()
        }
    }
}
