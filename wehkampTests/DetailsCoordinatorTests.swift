//
//  DetailsCoordinatorTests.swift
//  wehkampTests
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import wehkamp

class DetailsCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: DetailsCoordinator<MockDependency>?
    let department = Department.mockDepartment()

    override func setUp() {
        super.setUp()

        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        if let team = department?.mobileTeam.first,
           let member = team.members?.first {
            coordinator = DetailsCoordinator(
                dependency: localDependency,
                navigation: navigation,
                member: member,
                team: team
            )
        }
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
}
