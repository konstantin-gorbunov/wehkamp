//
//  MockDependency.swift
//  wehkampTests
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation
@testable import wehkamp

class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchMemberCompletion) -> Void)?

    func fetchMemberList(_ completion: @escaping DataProvider.FetchMemberCompletion) {
        onFetch?(completion)
    }
}

class MockDependency: Dependency {
    
//    let dataProvider: DataProvider = LocalMembersDataProvider()
    let dataProvider: DataProvider = MockDataProvider()
}

extension Department {
    
    static func mockDepartment() -> Department? {
        let member = Member(name: "Test Value", role: nil, image: nil, email: nil)
        let team = MobileTeam(team: "Test Team", members: [member])
        let department = Department(mobileTeam: [team])
        return department
    }
    
    static func mockEmptyDepartment() -> Department? {
        let department = Department(mobileTeam: [])
        return department
    }
    
    static func mockFilledDepartment() -> Department? {
        let memberFS = Member(name: "Frank Sinatra", role: "Singer", image: "https://en.wikipedia.org/wiki/File:Frank_Sinatra_(1957_studio_portrait_close-up).jpg", email: "fs@ua.fm")
        let memberWrongURL = Member(name: "Wrong Image", role: "Singer", image: "oad.wikimedia.org/Kos.jpg", email: "wi@ua.fm")
        let memberBM = Member(name: "Bob Marley", role: "Singer", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Bob-Marley.jpg/440px-Bob-Marley.jpg", email: "bm@ua.fm")
        let team = MobileTeam(team: "Best Team", members: [memberFS, memberWrongURL, memberBM])
        let department = Department(mobileTeam: [team])
        return department
    }
}
