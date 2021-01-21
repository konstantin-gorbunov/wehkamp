//
//  UIImage+Load.swift
//  wehkamp
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

/**
 The hit problems can arise.
 The alternative is https://github.com/rs/SDWebImage or implementing of own solution with cached data and priority queue.
 */
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
