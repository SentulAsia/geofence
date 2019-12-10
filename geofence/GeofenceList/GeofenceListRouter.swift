//
//  GeofenceListRouter.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol GeofenceListRoutingLogic {
    func routeToNext()
    func routeToAddGeofence()
}

protocol GeofenceListDataPassing {
    var dataStore: GeofenceListDataStore? { get }
}

class GeofenceListRouter: NSObject, GeofenceListRoutingLogic, GeofenceListDataPassing {

    // MARK: - Properties

    var tableViewController: GeofenceListTableViewController?
    var dataStore: GeofenceListDataStore?

    // MARK: - Routing

    func routeToNext() {
        // let destinationVC = UIStoryboard(name: "", bundle: nil).instantiateViewController(withIdentifier: "") as! NextViewController
        // var destinationDS = destinationVC.router!.dataStore!
        // passDataTo(destinationDS, from: dataStore!)
        // viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routeToAddGeofence() {
        let destinationVC = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: MapViewController.Constants.identifier) as! MapViewController
        tableViewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

    // func passDataTo(_ destinationDS: inout NextDataStore, from sourceDS: GeofenceListDataStore) {
    //     destinationDS.attribute = sourceDS.attribute
    // }
}
