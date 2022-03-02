//
//  DetailsCoordinator.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol DetailsDelegate: AnyObject {
    func onDetailsFlowFinished<T>(_ coordinator: Coordinator<T>)
}

/// Member Details Coordinator
class DetailsCoordinator<T: Dependency>: Coordinator<T> {

    private let navigationController: UINavigationController
    private let member: Member
    private let team: MobileTeam
    private let title = NSLocalizedString("Employee", comment: "Employee in title")

    weak var delegate: DetailsDelegate?

    private(set) lazy var detailViewController = DetailsViewController(nibName: nil, bundle: nil)

    init(dependency: T, navigation: UINavigationController, member: Member, team: MobileTeam) {
        self.navigationController = navigation
        self.member = member
        self.team = team
        super.init(dependency: dependency)
    }

    override func start() {
        super.start()
        detailViewController.delegate = self
        detailViewController.viewModel = DetailsViewModel(member: member, team: team)
        detailViewController.title = title
        navigationController.pushViewController(detailViewController, animated: true)
    }

    override func stop() {
        delegate?.onDetailsFlowFinished(self)
        super.stop()
    }
}

extension DetailsCoordinator: DetailsViewDelegate {

    func onDetailsViewFinished(_ viewController: UIViewController) {
        stop()
    }
}
