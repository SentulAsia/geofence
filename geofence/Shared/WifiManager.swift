//
//  WifiManager.swift
//  geofence
//
//  Created by Zaid Said on 16/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

struct WifiManager {

    // MARK: Fetch Wifi SSID

    func fetchWifiSSID(completion: @escaping (String?) -> Void) {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as? NSArray {
            for interface in interfaces {
                if let networkInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as? NSDictionary {
                    ssid = networkInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }

        completion(ssid)
    }
}
