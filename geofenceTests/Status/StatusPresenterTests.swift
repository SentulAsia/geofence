//
//  StatusPresenterTests.swift
//  geofenceTests
//
//  Created by Zaid Said on 16/12/2019.
//  Copyright © 2019 Zaid M. Said. All rights reserved.
//

@testable import geofence
import XCTest

class StatusPresenterTests: XCTestCase {

    // MARK: - Subject Under Test (SUT)

    var sut: StatusPresenter!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        setupStatusPresenter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Setup

    func setupStatusPresenter() {
        sut = StatusPresenter()
    }

    // MARK: - Test Doubles

    class StatusDisplayLogicSpy: StatusDisplayLogic {

        // MARK: Spied Methods

        var displayFetchFromLocalDataStoreCalled = false
        var fetchFromLocalDataStoreViewModel: StatusModels.FetchFromLocalDataStore.ViewModel!
        func displayFetchFromLocalDataStore(with viewModel: StatusModels.FetchFromLocalDataStore.ViewModel) {
            displayFetchFromLocalDataStoreCalled = true
            fetchFromLocalDataStoreViewModel = viewModel
        }

        var displayFetchGeofenceStatusCalled = false
        var fetchFetchGeofenceStatusViewModel: StatusModels.FetchGeofenceStatus.ViewModel!
        func displayFetchGeofenceStatus(with viewModel: StatusModels.FetchGeofenceStatus.ViewModel) {
            displayFetchGeofenceStatusCalled = true
            fetchFetchGeofenceStatusViewModel = viewModel
        }

        var displayFetchWifiSSIDCalled = false
        var fetchWifiSSIDViewModel: StatusModels.FetchWifiSSID.ViewModel!
        func displayFetchWifiSSID(with viewModel: StatusModels.FetchWifiSSID.ViewModel) {
            displayFetchWifiSSIDCalled = true
            fetchWifiSSIDViewModel = viewModel
        }
    }

    // MARK: - Tests

    func testPresentFetchFromLocalDataStoreShouldAskTheViewControllerToDisplay() {
        // given
        let spy = StatusDisplayLogicSpy()
        sut.viewController = spy
        let response = StatusModels.FetchFromLocalDataStore.Response()

        // when
        sut.presentFetchFromLocalDataStore(with: response)

        // then
        XCTAssertTrue(spy.displayFetchFromLocalDataStoreCalled, "presentFetchFromLocalDataStore(with:) should ask the view controller to display the result")
    }

    func testPresentFetchGeofenceStatusShouldAskTheViewControllerToDisplay() {
        // given
        let spy = StatusDisplayLogicSpy()
        sut.viewController = spy
        let response = StatusModels.FetchGeofenceStatus.Response()

        // when
        sut.presentFetchGeofenceStatus(with: response)

        // then
        XCTAssertTrue(spy.displayFetchGeofenceStatusCalled, "presentFetchGeofenceStatus(with:) should ask the view controller to display the result")
    }

    func testPresentFetchWifiSSIDShouldAskTheViewControllerToDisplay() {
        // given
        let spy = StatusDisplayLogicSpy()
        let wifiEnabled = false
        let status = StatusModels.GeofenceStatus.inside
        sut.viewController = spy
        let response = StatusModels.FetchWifiSSID.Response(wifiEnabled: wifiEnabled, status: status)

        // when
        sut.presentFetchWifiSSID(with: response)

        // then
        XCTAssertTrue(spy.displayFetchWifiSSIDCalled, "presentFetchWifiSSID(with:) should ask the view controller to display the result")
    }
}
