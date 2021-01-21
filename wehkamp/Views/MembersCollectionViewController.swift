//
//  CustomerCollectionViewController.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

protocol MembersCollectionViewDelegate: class {
    func didSelectMember(_ customer: Member, in team: MobileTeam)
}

class MembersCollectionViewController: BaseCollectionViewController {

    private let viewModel: MemberListViewModel
    weak var delegate: MembersCollectionViewDelegate?

    init(viewModel: MemberListViewModel, layout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureCell(_ cell: MemberViewCell, at indexPath: IndexPath) {
        guard let member = viewModel.mobileTeams[indexPath.section].members?[indexPath.row] else {
            return
        }
        cell.viewModel = MemberViewModel(
            member: member,
            borderSides: BorderLayer.Side.border(at: indexPath)
        )
    }
    
    override func configureHeader(_ header: SectionHeader, at indexPath: IndexPath) {
        let obj = viewModel.mobileTeams[indexPath.section]
        header.viewModel = TeamViewModel(
            name: obj.team
        )
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.mobileTeams.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mobileTeams[section].members?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team = viewModel.mobileTeams[indexPath.section]
        guard let member = team.members?[indexPath.row] else {
            return
        }
        delegate?.didSelectMember(member, in: team)
    }
}
