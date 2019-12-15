//
//  MapRouter.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol MapRoutingLogic {
    func routeToGeofenceStatus()
}

protocol MapDataPassing {
    var dataStore: MapDataStore? { get }
}

class MapRouter: NSObject, MapRoutingLogic, MapDataPassing {

    // MARK: - Properties

    var viewController: MapViewController?
    var dataStore: MapDataStore?

    // MARK: - Routing

    func routeToGeofenceStatus() {
        viewController?.navigationController?.popViewController(animated: true)
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: MapDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
