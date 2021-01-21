//
//  UICollectionView+Dequeue.swift
//  wehkamp
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(_ instantiatable: NibInstantiatable.Type) {
        self.register(
            UINib(nibName: instantiatable.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: instantiatable.nibIdentifier
        )
    }
    
    func registerHeader(_ instantiatable: NibInstantiatable.Type) {
        self.register(
            UINib(nibName: instantiatable.nibIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: instantiatable.nibIdentifier
        )
    }

    func dequeue<T: NibInstantiatable>(at indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return T.dequeue(in: self, at: indexPath)
    }
    
    func dequeue<T: NibInstantiatable>(viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> T where T: UICollectionReusableView {
        return T.dequeue(in: self, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
