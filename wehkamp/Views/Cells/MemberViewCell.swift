//
//  CustomerViewCell.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class MemberViewCell: UICollectionViewCell, NibInstantiatable {

    @IBOutlet private weak var borderedView: BorderedView? {
        didSet {
            borderedView?.borderColor = UIColor.orange.cgColor
        }
    }
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var imageView: UIImageView?

    var viewModel: MemberViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel?.text = viewModel.name
            borderedView?.borderSides = viewModel.borderSides
            if let imageUrl = viewModel.imageUrl {
                imageView?.load(url: imageUrl)
            }
        }
    }
}
