//
//  DetailsViewModel.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

struct DetailsViewModel {
    let name: String
    let team: String
    let role: String?
    let email: String?
    let imageUrl: URL?
    
    init(member: Member, team: MobileTeam) {
        name = member.name
        role = member.role
        email = member.email
        self.team = team.team
        if let imageStrURL = member.image, DetailsViewModel.verifyUrl(urlString: imageStrURL) {
            imageUrl = URL.init(string: imageStrURL)
        }
        else {
            imageUrl = nil
        }
    }
    
    private static func verifyUrl (urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}
