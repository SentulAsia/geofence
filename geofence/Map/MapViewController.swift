//
//  MapViewController.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit
import MapKit

protocol MapDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MapModels.FetchFromLocalDataStore.ViewModel)
    func displayPerformChangeRadiusValue(with viewModel: MapModels.PerformChangeRadiusValue.ViewModel)
    func displayPerformAddGeofence(with viewModel: MapModels.PerformAddGeofence.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic {

    // MARK: - Properties

    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    var interactor: MapBusinessLogic?

    enum Constants {
        static let identifier = "MapVC"
        static let regionMeters: CLLocationDistance = 10000
        static let errorHeight: CGFloat = 88
    }

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
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()

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
        setupTableView()
        setupNoticeView()
    }

    // MARK: - Table View

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    func setupTableView() {
        tableView.dataSource = self
        tableView.isHidden = true
        tableViewHeightConstraint.constant = 0
    }

    // MARK: - Map View

    @IBOutlet var mapView: MKMapView!
    func setupMapView() {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: Constants.regionMeters, longitudinalMeters: Constants.regionMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    // MARK: - Notice View

    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var noticeViewHeightConstraint: NSLayoutConstraint!
    func setupNoticeView() {
        noticeLabel.text = ""
        noticeViewHeightConstraint.constant = 0
    }

    // MARK: - Use Case - Fetch From Local DataStore

    @IBOutlet var addGeofenceButton: UIButton!
    @IBOutlet var radiusLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    func setupFetchFromLocalDataStore() {
        let request = MapModels.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: MapModels.FetchFromLocalDataStore.ViewModel) {
        addGeofenceButton.setTitle(viewModel.geofenceButtonText, for: .normal)
        performChangeRadiusValue(self)
    }

    // MARK: - Use Case - Change Radius Value

    @IBAction func performChangeRadiusValue(_ sender: Any) {
        noticeViewHeightConstraint.constant = 0

        let request = MapModels.PerformChangeRadiusValue.Request(radiusValue: stepper.value.intValue)
        interactor?.performChangeRadiusValue(with: request)
    }

    func displayPerformChangeRadiusValue(with viewModel: MapModels.PerformChangeRadiusValue.ViewModel) {
        radiusLabel.text = viewModel.radiusLabelText
    }

    // MARK: - Use Case - Add Geofence

    @IBAction  func performAddGeofence(_ sender: Any) {
        let request = MapModels.PerformAddGeofence.Request(coordinate: mapView.centerCoordinate, radiusValue: stepper.value.intValue)
        interactor?.performAddGeofence(with: request)
    }

    func displayPerformAddGeofence(with viewModel: MapModels.PerformAddGeofence.ViewModel) {
        if let error = viewModel.error {
            switch error.type {
            case .invalidRadius:
                noticeLabel.text = error.message

            case .invalidCoordinate:
                noticeLabel.text = error.message
            }

            noticeViewHeightConstraint.constant = Constants.errorHeight
            return
        }

        router?.routeToGeofenceStatus()
    }
}

// MARK: - Table View Data Source

extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: handle this in Wifi SSID task
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WifiSSIDTableViewCell.Constants.identifier, for: indexPath) as! WifiSSIDTableViewCell
        return cell
    }
}
