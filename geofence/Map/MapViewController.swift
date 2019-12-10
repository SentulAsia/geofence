//
//  MapViewController.swift
//  geofence
//
//  Created by Zaid Said on 03/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol MapDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: MapModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: MapModels.FetchFromRemoteDataStore.ViewModel)
    func displayPerformMap(with viewModel: MapModels.PerformMap.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic {

    // MARK: - Properties

    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    var interactor: MapBusinessLogic?

    enum Constants {
        static let identifier = "MapVC"
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchFromRemoteDataStore()
    }

    // MARK: - Table View

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    func setupTableView() {
        tableView.dataSource = self
        tableView.isHidden = true
        tableViewHeightConstraint.constant = 0
    }

    // MARK: - Use Case - Fetch From Local DataStore

    @IBOutlet var exampleLocalLabel: UILabel! = UILabel()
    func setupFetchFromLocalDataStore() {
        let request = MapModels.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: MapModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = MapModels.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: MapModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }

    // MARK: - Use Case - Map

    func performMap(_ sender: Any) {
        let request = MapModels.PerformMap.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performMap(with: request)
    }

    func displayPerformMap(with viewModel: MapModels.PerformMap.ViewModel) {
        // handle error and ui element error states
        // based on error type
        if let error = viewModel.error {
            switch error.type {
            case .emptyExampleVariable:
                exampleLocalLabel.text = error.message

            case .apiError:
                exampleLocalLabel.text = error.message
            }
            return
        }

        // handle ui element success state and
        // route to next screen
        router?.routeToNext()
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
