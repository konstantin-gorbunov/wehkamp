//
//  HomeCoordinatorTests.swift
//  wehkampTests
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import wehkamp

class HomeCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: HomeCoordinator<MockDependency>?

    override func setUp() {
        super.setUp()
        
        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = HomeCoordinator(
            dependency: localDependency,
            navigation: navigation
        )
    }

    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }

    func testLoadingScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        guard let department = Department.mockDepartment() else {
            XCTFail("Can't create mock department")
            return
        }
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success(department))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is MembersCollectionViewController)
    }

    func testErrorScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        guard let department = Department.mockEmptyDepartment() else {
            XCTFail("Can't create mock empty department")
            return
        }
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success(department))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
    }

    func testShowDetails() {
        let expectation = self.expectation(description: "Data Fetched")
        guard let department = Department.mockDepartment() else {
            XCTFail("Can't create mock department")
            return
        }
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success(department))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        wait(for: [expectation], timeout: 5)
        guard let collectionController = coordinator?.navigationViewController.visibleViewController as? UICollectionViewController else {
            XCTFail()
            return
        }
        collectionController.collectionView(collectionController.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(coordinator?.childCoordinators.first(where: { $0 is DetailsCoordinator }))
    }
}
