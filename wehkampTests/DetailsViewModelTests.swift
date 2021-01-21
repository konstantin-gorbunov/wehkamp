//
//  DetailsViewModelTests.swift
//  wehkampTests
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import wehkamp

class DetailsViewModelTests: XCTestCase {
    
    func testBaseMapping() {
        guard let department = Department.mockDepartment() else {
            XCTFail("Can't create mock department")
            return
        }
        guard let team = department.mobileTeam.first,
              let member = team.members?.first else {
            XCTFail("Can't get mock team or member")
            return
        }
        XCTAssertEqual(team.team, "Test Team")
        XCTAssertNotNil(team.members)
        
        let model = DetailsViewModel(member: member, team: team)
        XCTAssertEqual(model.name, "Test Value")
        XCTAssertEqual(model.team, "Test Team")
        XCTAssertNil(model.role)
        XCTAssertNil(model.email)
        XCTAssertNil(model.imageUrl)
    }
    
    func testFilledBaseMapping() {
        guard let department = Department.mockFilledDepartment() else {
            XCTFail("Can't create mock department")
            return
        }
        guard let team = department.mobileTeam.first,
              let memberFirst = team.members?.first,
              let memberLast = team.members?.last else {
            XCTFail("Can't get mock team or members")
            return
        }
        XCTAssertEqual(team.team, "Best Team")
        XCTAssertNotNil(team.members)
        
        let modelFirst = DetailsViewModel(member: memberFirst, team: team)
        XCTAssertEqual(modelFirst.name, "Frank Sinatra")
        XCTAssertEqual(modelFirst.team, "Best Team")
        XCTAssertEqual(modelFirst.email, "fs@ua.fm")
        XCTAssertNotNil(modelFirst.imageUrl)
        
        let modelSecond = DetailsViewModel(member: memberLast, team: team)
        XCTAssertEqual(modelSecond.name, "Bob Marley")
        XCTAssertEqual(modelSecond.team, "Best Team")
        XCTAssertEqual(modelSecond.email, "bm@ua.fm")
        XCTAssertNotNil(modelSecond.imageUrl)
    }
        
    func testWrongImageURL() {
        guard let department = Department.mockFilledDepartment() else {
            XCTFail("Can't create mock department")
            return
        }
        guard let team = department.mobileTeam.first,
              let members = team.members else {
            XCTFail("Can't get mock team or members")
            return
        }
        XCTAssertEqual(team.team, "Best Team")
        XCTAssertNotNil(team.members)
        
        if members.count < 2 {
            XCTFail("Members size is too small")
            return
        }
        let memberSecond = members[1]
        let model = DetailsViewModel(member: memberSecond, team: team)
        XCTAssertEqual(model.name, "Wrong Image")
        XCTAssertEqual(model.team, "Best Team")
        XCTAssertEqual(model.email, "wi@ua.fm")
        XCTAssertNil(model.imageUrl)
    }
}
