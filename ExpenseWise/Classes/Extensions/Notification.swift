//
//  Notification.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import Foundation
import UIKit

open class NotificationManager {
    fileprivate var observerTokens: [Any] = []

    public init() {}

    deinit {
        deregisterAll()
    }

    open func deregisterAll() {
        for token in observerTokens {
            NotificationCenter.default.removeObserver(token)
        }

        observerTokens = []
    }

    open func addObserver(forName name: NSNotification.Name, action: @escaping ((Notification) -> Void)) {
        let newToken = NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { note in
            action(note)
        }

        observerTokens.append(newToken)
    }

    open func addObserver(forNameString name: String, forObject object: Any? = nil, action: @escaping ((Notification) -> Void)) {
        let newToken = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: object, queue: nil) { note in
            action(note)
        }

        observerTokens.append(newToken)
    }
}

public struct NotificationGroup {
    let entries: [String]

    init(_ newEntries: String...) {
        entries = newEntries
    }
}

public extension NotificationManager {
    public func addGroupObserver(_ group: NotificationGroup, action: @escaping ((Notification) -> Void)) {
        for name in group.entries {
            addObserver(forNameString: name, action: action)
        }
    }
}

public extension Notification {
    public var keyboardHeight: CGFloat {
        if let keyboardSize = (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            return keyboardSize.height
        }
        return 0
    }

    public var keyboardAnimationDuration: Double {
        if let animationDuration = self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            return animationDuration
        }
        return 0
    }

    public var keyboardAnimationOptions: UIView.AnimationOptions {
        if let options = self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            return UIView.AnimationOptions(rawValue: UInt(options << 16))
        }
        return UIView.AnimationOptions.curveEaseIn
    }

    public var keyboardAnimationType: UIView.AnimationOptions {
        return keyboardAnimationOptions
    }
}

public extension NotificationManager {
    public func postNotification(withName aName: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: aName, object: object, userInfo: userInfo)
    }

    public func postNotification(withNameString aName: String, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: aName), object: object, userInfo: userInfo)
    }
}
