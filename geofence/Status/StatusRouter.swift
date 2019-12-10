//
//  StatusRouter.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol StatusRoutingLogic {
    func routeToGeofenceList()
}

protocol StatusDataPassing {
    var dataStore: StatusDataStore? { get }
}

class StatusRouter: NSObject, StatusRoutingLogic, StatusDataPassing {

    // MARK: - Properties

    var viewController: StatusViewController?
    var dataStore: StatusDataStore?

    // MARK: - Routing

    func routeToGeofenceList() {
         let destinationVC = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: GeofenceListTableViewController.Constants.identifier) as! GeofenceListTableViewController
//         var destinationDS = destinationVC.router!.dataStore!
//         passDataTo(destinationDS, from: dataStore!)
         viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: - Data Passing

//     func passDataTo(_ destinationDS: inout MapDataStore, from sourceDS: StatusDataStore) {
//         destinationDS.attribute = sourceDS.attribute
//     }
}
