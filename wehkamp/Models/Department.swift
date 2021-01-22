//
//  Department.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

struct Department: Codable {
    let mobileTeam: [MobileTeam]
    
    var isEmpty: Bool {
        return mobileTeam.isEmpty
    }
}
