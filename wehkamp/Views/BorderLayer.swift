//
//  BorderLayer.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class BorderLayer: CALayer {

    struct Side: OptionSet {
        typealias RawValue = Int
        var rawValue: Int
        init(rawValue: RawValue) {
            self.rawValue = rawValue
        }
        static let top    = Side(rawValue: 0b0001)
        static let left   = Side(rawValue: 0b0010)
        static let right  = Side(rawValue: 0b0100)
        static let bottom = Side(rawValue: 0b1000)

        static let all: Side = [.top, .left, .right, .bottom]
    }

    var sides: Side = .all {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(in ctx: CGContext) {
        guard sides.isEmpty == false,
            let borderColor = borderColor else {
            ctx.clear(self.bounds)
            return
        }

        ctx.clear(self.bounds)
        ctx.setLineWidth(2)
        ctx.setStrokeColor(borderColor)
        ctx.setLineCap(.round)
        let path = UIBezierPath()
        // top
        if sides.contains(.top) {
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: 0))
        }
        // right
        if sides.contains(.right) {
            path.move(to: CGPoint(x: self.bounds.maxX, y: 0))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        }
        // left
        if sides.contains(.left) {
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: 0, y: self.bounds.maxY))
        }
        // bottom
        if sides.contains(.bottom) {
            path.move(to: CGPoint(x: 0, y: self.bounds.maxY))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        }

        ctx.addPath(path.cgPath)
        ctx.strokePath()
    }
}

extension BorderLayer.Side {
    /// Return border sides for given index path
    /// This is related to customer list view with given items per row
    static func border(at indexPath: IndexPath,
                       itemsInRow: Int = BaseCollectionViewController.Constants.itemsInRow) -> BorderLayer.Side {
        var result: BorderLayer.Side = [.bottom, .right]
        if indexPath.row < itemsInRow {
            result.insert(.top)
        }
        if indexPath.row % itemsInRow == 0 {
            result.insert([.left])
        }
        return result
    }
}
