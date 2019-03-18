//
//  UIView.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

// MARK: - UIView

@IBDesignable public extension UIView {
    public var height: CGFloat {
        get { return frame.size.height }
        set { frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: newValue) }
    }

    public var width: CGFloat {
        get { return frame.size.width }
        set { frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue, height: frame.size.height) }
    }

    public var x: CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(x: newValue, y: frame.origin.y, width: frame.size.width, height: frame.size.height) }
    }

    public var y: CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(x: frame.origin.x, y: newValue, width: frame.size.width, height: frame.size.height) }
    }

    public var yCenter: CGFloat {
        get { return y + height / 2.0 }
        set { y = yCenter - height / 2.0 }
    }

    public var xCenter: CGFloat {
        get { return x + width / 2.0 }
        set { x = newValue - width / 2.0 }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
        get { return layer.cornerRadius }
    }

    @IBInspectable public var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }

    @IBInspectable public var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor!) }
    }
}
