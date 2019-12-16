//
//  StatusViewController.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol StatusDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: StatusModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchGeofenceStatus(with viewModel: StatusModels.FetchGeofenceStatus.ViewModel)
    func displayFetchWifiSSID(with viewModel: StatusModels.FetchWifiSSID.ViewModel)
}

class StatusViewController: UIViewController, StatusDisplayLogic {

    // MARK: - Properties

    var router: (NSObjectProtocol & StatusRoutingLogic & StatusDataPassing)?
    var interactor: StatusBusinessLogic?

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = StatusInteractor()
        let presenter = StatusPresenter()
        let router = StatusRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchGeofenceStatus()
    }

    // MARK: - Use Case - Fetch From Local DataStore

    @IBOutlet var geofenceStatusLabel: UILabel!
    func setupFetchFromLocalDataStore() {
        let request = StatusModels.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: StatusModels.FetchFromLocalDataStore.ViewModel) {
        geofenceStatusLabel.text = viewModel.geofenceStatus
    }

    // MARK: - Use Case - Fetch Geofence Status

    @IBOutlet var noticeLabel: UILabel!
    func setupFetchGeofenceStatus() {
        let request = StatusModels.FetchGeofenceStatus.Request()
        interactor?.fetchGeofenceStatus(with: request)
    }

    func displayFetchGeofenceStatus(with viewModel: StatusModels.FetchGeofenceStatus.ViewModel) {
        if let error = viewModel.error {
            noticeLabel.text = error.message
        } else {
            noticeLabel.text = ""
        }

        geofenceStatusLabel.text = viewModel.geofenceStatus

        if viewModel.status == .inside {
            statusBorderView.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        } else {
            setupFetchWifiSSID()
        }
    }

    // MARK: - Use Case - Fetch Wifi SSID

    @IBOutlet var wifiImageView: UIImageView!
    @IBOutlet var statusBorderView: UIView!
    var wifiSSID: String?
    func setupFetchWifiSSID() {
        let request = StatusModels.FetchWifiSSID.Request()
        interactor?.fetchWifiSSID(with: request)
    }

    func displayFetchWifiSSID(with viewModel: StatusModels.FetchWifiSSID.ViewModel) {
        geofenceStatusLabel.text = viewModel.geofenceStatus
        
        if viewModel.wifiEnabled {
            wifiImageView.image = #imageLiteral(resourceName: "wi-fi-connected")
            statusBorderView.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        } else {
            wifiImageView.image = #imageLiteral(resourceName: "wi-fi-disconnected")
            statusBorderView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }

    // MARK: - Use Case - Add Geofence

    @IBAction func performAddGeofence(_ sender: Any) {
        router?.routeToAddGeofence()
    }
}
