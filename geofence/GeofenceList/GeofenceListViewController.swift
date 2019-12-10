//
//  GeofenceListViewController.swift
//  geofence
//
//  Created by Zaid Said on 09/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

import UIKit

protocol GeofenceListDisplayLogic: class {
    func displayFetchFromLocalDataStore(with viewModel: GeofenceListModels.FetchFromLocalDataStore.ViewModel)
    func displayFetchFromRemoteDataStore(with viewModel: GeofenceListModels.FetchFromRemoteDataStore.ViewModel)
    func displayTrackAnalytics(with viewModel: GeofenceListModels.TrackAnalytics.ViewModel)
    func displayPerformGeofenceList(with viewModel: GeofenceListModels.PerformGeofenceList.ViewModel)
}

class GeofenceListTableViewController: UITableViewController, GeofenceListDisplayLogic {

    // MARK: - Properties

    var router: (NSObjectProtocol & GeofenceListRoutingLogic & GeofenceListDataPassing)?
    var interactor: GeofenceListBusinessLogic?

    enum Constants {
        static let identifier = "GeofenceListVC"
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
        let tableViewController = self
        let interactor = GeofenceListInteractor()
        let presenter = GeofenceListPresenter()
        let router = GeofenceListRouter()

        tableViewController.router = router
        tableViewController.interactor = interactor
        interactor.presenter = presenter
        presenter.tableViewController = tableViewController
        router.tableViewController = tableViewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchFromLocalDataStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchFromRemoteDataStore()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        trackScreenViewAnalytics()
        registerNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterNotifications()
    }

    // MARK: - Notifications

    func registerNotifications() {
        let selector = #selector(trackScreenViewAnalytics)
        let notification = UIApplication.didBecomeActiveNotification
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }

    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Use Case - Fetch From Local DataStore

    @IBOutlet var exampleLocalLabel: UILabel! = UILabel()
    func setupFetchFromLocalDataStore() {
        let request = GeofenceListModels.FetchFromLocalDataStore.Request()
        interactor?.fetchFromLocalDataStore(with: request)
    }

    func displayFetchFromLocalDataStore(with viewModel: GeofenceListModels.FetchFromLocalDataStore.ViewModel) {
        exampleLocalLabel.text = viewModel.exampleTranslation
    }

    // MARK: - Use Case - Fetch From Remote DataStore

    @IBOutlet var exampleRemoteLabel: UILabel! = UILabel()
    func setupFetchFromRemoteDataStore() {
        let request = GeofenceListModels.FetchFromRemoteDataStore.Request()
        interactor?.fetchFromRemoteDataStore(with: request)
    }

    func displayFetchFromRemoteDataStore(with viewModel: GeofenceListModels.FetchFromRemoteDataStore.ViewModel) {
        exampleRemoteLabel.text = viewModel.exampleVariable
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // MARK: - Use Case - Track Analytics

    @objc func trackScreenViewAnalytics() {
        trackAnalytics(event: .screenView)
    }

    func trackAnalytics(event: GeofenceListModels.AnalyticsEvents) {
        let request = GeofenceListModels.TrackAnalytics.Request(event: event)
        interactor?.trackAnalytics(with: request)
    }

    func displayTrackAnalytics(with viewModel: GeofenceListModels.TrackAnalytics.ViewModel) {
        // do something after tracking analytics (if needed)
    }

    // MARK: - Use Case - GeofenceList

    func performGeofenceList(_ sender: Any) {
        let request = GeofenceListModels.PerformGeofenceList.Request(exampleVariable: exampleLocalLabel.text)
        interactor?.performGeofenceList(with: request)
    }

    func displayPerformGeofenceList(with viewModel: GeofenceListModels.PerformGeofenceList.ViewModel) {
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

    // MARK: - Use Case - Add Geofence

    @IBAction func performAddGeofence(_ sender: Any) {
        router?.routeToAddGeofence()
    }
}
