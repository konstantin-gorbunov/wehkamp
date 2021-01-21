//
//  BaseCollectionViewController.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {

     struct Constants {
        static let itemsInRow = 2
        static let lineSpacing: CGFloat = 0
        static let rowSpacing: CGFloat = 0
        static let cellHeight: CGFloat = 200
        static let headerHeight: CGFloat = 30

        static func cellWidth(in view: UIView) -> CGFloat {
            assert(itemsInRow >= 0)
            let availableWidth = view.bounds.width - (lineSpacing * CGFloat(itemsInRow - 1))
            return availableWidth / CGFloat(itemsInRow)
        }
    }

    var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }

    func configureCell(_ cell: MemberViewCell, at indexPath: IndexPath) {
        /* Call in subclass to configure Cell */
    }
    
    func configureHeader(_ header: SectionHeader, at indexPath: IndexPath) {
        /* Call in subclass to configure Header */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        flowLayout?.itemSize = CGSize(width: Constants.cellWidth(in: self.view), height: Constants.cellHeight)
        flowLayout?.minimumLineSpacing = Constants.lineSpacing
        flowLayout?.minimumInteritemSpacing = Constants.rowSpacing

        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .lightGray
        collectionView?.register(MemberViewCell.self)
        collectionView?.registerHeader(SectionHeader.self)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Should be overriden in subclass")
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemberViewCell = collectionView.dequeue(at: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: SectionHeader = collectionView.dequeue(viewForSupplementaryElementOfKind: kind, at: indexPath)
        configureHeader(header, at: indexPath)
        return header
    }
}


extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.headerHeight)
    }
}
