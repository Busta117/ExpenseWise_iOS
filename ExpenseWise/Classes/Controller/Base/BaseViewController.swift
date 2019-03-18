//
//  BaseViewController.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    var notificationManager = NotificationManager()

    var disposeBag: DisposeBag = DisposeBag() // RX

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppereance()
        dataBinding()
    }

    func configureAppereance() {
        view.backgroundColor = UIColor(white: 250.0 / 255.0, alpha: 1)
    }

    func dataBinding() {}

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        notificationManager.deregisterAll()
        super.dismiss(animated: flag, completion: completion)
    }

    deinit {
        disposeBag = DisposeBag()
        notificationManager.deregisterAll()
        NotificationCenter.default.removeObserver(self)
        print("*********Deallocating \(Mirror(reflecting: self).subjectType) ****************")
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
