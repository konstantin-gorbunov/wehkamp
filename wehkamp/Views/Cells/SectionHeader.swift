//
//  SectionHeader.swift
//  wehkamp
//
//  Created by Kostya on 20/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView, NibInstantiatable {
    @IBOutlet private weak var sectionHeaderlabel: UILabel?
    
    var viewModel: TeamViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            sectionHeaderlabel?.text = viewModel.name
        }
    }
}
