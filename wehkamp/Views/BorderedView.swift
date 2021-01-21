//
//  BorderedView.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class BorderedView: UIView {

    override class var layerClass: AnyClass {
        return BorderLayer.self
    }

    var borderSides: BorderLayer.Side {
        get {
            return borderLayer.sides
        }
        set {
            borderLayer.sides = newValue
        }
    }

    var borderColor: CGColor? {
        get {
            return borderLayer.borderColor
        }
        set {
            borderLayer.borderColor = newValue
            borderLayer.setNeedsDisplay()
        }
    }

    private var borderLayer: BorderLayer {
        return self.layer as! BorderLayer
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()

        if let window = window {
            borderLayer.contentsScale = window.screen.scale
            borderLayer.setNeedsDisplay()
        }
    }
}
