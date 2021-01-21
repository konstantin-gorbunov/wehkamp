//
//  ImageViewPopup.swift
//  wehkamp
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

final class ImageViewPopup: UIImageView {
    private var tempRect: CGRect?
    private var bgView: UIView?
    
    private var animated: Bool = true
    private var intDuration: TimeInterval = 0.25
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popUpImageToFullScreen))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func exitFullScreen () {
        guard let imageV = bgView?.subviews.first as? UIImageView else { return }
        
        UIView.animate(withDuration: intDuration, animations: {
            if let tempRect = self.tempRect {
                imageV.frame = tempRect
            }
            self.bgView?.alpha = 0
        }) { [weak self] _ in
            self?.bgView?.removeFromSuperview()
        }
    }
    
    @objc private func popUpImageToFullScreen() {
        guard let parentView = findParentViewController()?.view else { return }
        guard let window = parentView.window else { return }
        
        let bgView = UIView(frame: UIScreen.main.bounds)
        self.bgView = bgView
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exitFullScreen)))
        bgView.alpha = 0
        bgView.backgroundColor = UIColor.black
        let imageV = UIImageView(image: self.image)
        let point = convert(self.bounds, to: parentView)
        imageV.frame = point
        tempRect = point
        imageV.contentMode = .scaleAspectFit
        bgView.addSubview(imageV)
        window.addSubview(bgView)
        
        if animated {
            UIView.animate(withDuration: intDuration, animations: {
                bgView.alpha = 1
                imageV.frame = CGRect(x: 0, y: 0, width: parentView.frame.width, height: parentView.frame.width)
                imageV.center = parentView.center
            })
        }
    }
    
    private func findParentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
