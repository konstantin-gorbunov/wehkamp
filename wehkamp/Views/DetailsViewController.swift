//
//  DetailsViewController.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func onDetailsViewFinished(_ viewController: UIViewController)
}

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var fullName: UILabel?
    @IBOutlet private weak var department: UILabel?
    @IBOutlet private weak var role: UILabel?
    @IBOutlet private weak var emailTextView: UITextView?
    @IBOutlet private weak var avatar: ImageViewPopup?

    weak var delegate: DetailsViewDelegate?

    var viewModel: DetailsViewModel? {
        didSet {
            loadViewIfNeeded()
            fullName?.text = viewModel?.name
            role?.text = viewModel?.role
            emailTextView?.text = viewModel?.email
            if let imageUrl = viewModel?.imageUrl {
                avatar?.load(url: imageUrl)
            }
            if let team = viewModel?.team {
                department?.text = String.localizedStringWithFormat(
                    NSLocalizedString("Team: %@", comment: "Team prefix"), team)
            }
        }
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            delegate?.onDetailsViewFinished(self)
        }
    }
}
