//
//  MemberViewModel.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

struct MemberViewModel {
    let name: String
    let imageUrl: URL?
    let borderSides: BorderLayer.Side
    
    init(member: Member, borderSides: BorderLayer.Side) {
        name = member.name
        self.borderSides = borderSides
        guard let imageStrURL = member.image else {
            imageUrl = nil
            return
        }
        imageUrl = URL.init(string: imageStrURL)
    }
}
