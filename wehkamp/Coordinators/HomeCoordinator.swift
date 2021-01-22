//
//  HomeCoordinator.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit
    
/// Home (Member List) Coordinator
class HomeCoordinator<T: Dependency>: Coordinator<T> {
    
    let navigationViewController: UINavigationController
    private let title = NSLocalizedString("Departments", comment: "Departments in title")
    
    init(dependency: T, navigation: UINavigationController) {
        self.navigationViewController = navigation
        super.init(dependency: dependency)
    }

    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title

        dependency.dataProvider.fetchMemberList { [weak self] result in
            self?.processResults(result)
        }
    }

    private func processResults(_ result: DataProvider.FetchMemberResult) {
        guard case .success(let department) = result, department.isEmpty == false else {
            let errorViewController = ErrorViewController(nibName: nil, bundle: nil)
            errorViewController.title = title
            navigationViewController.viewControllers = [errorViewController]
            return
        }

        let membersViewController = MembersCollectionViewController(
            viewModel: MemberListViewModel(mobileTeams: department.mobileTeam),
            layout: UICollectionViewFlowLayout()
        )
        membersViewController.title = title
        membersViewController.delegate = self
        navigationViewController.viewControllers = [membersViewController]
    }
}

extension HomeCoordinator: MembersCollectionViewDelegate {

    func didSelectMember(_ member: Member, in team: MobileTeam) {
        let detailsCoordinator = DetailsCoordinator(
            dependency: dependency,
            navigation: navigationViewController,
            member: member,
            team: team
        )
        add(childCoordinator: detailsCoordinator)
        detailsCoordinator.start()
    }
}
