//
//  AppCoordinator.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class AppCoordinator {
    weak var navigationController: UINavigationController?
    fileprivate weak var window: UIWindow?

    func start(window: UIWindow?) {
        self.window = window
        dbMigration.migrate()

        Category.create() // create the basic categories

        if navigationController == nil {
            let navigation = UINavigationController(rootViewController: CategoryListViewController.launch())
            self.window?.rootViewController = navigation
            navigationController = navigation
        }
    }
}
