//
//  HomeViewController.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa
import RxRealm
import DateToolsSwift

class HomeViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureAppereance() {
        super.configureAppereance()
    }

    override func dataBinding() {
        super.dataBinding()

        viewModel.history.asObservable().subscribe(onNext: { expenses in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

    @IBAction func newExpenseAction(_ sender: Any) {
        navigationController?.pushViewController(AddExpenseViewController.launch(), animated: true)
    }
}

extension HomeViewController {
    class func launch() -> HomeViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.history.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.history.value[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")

        let expense = viewModel.history.value[indexPath.section][indexPath.row]
        cell.textLabel?.text = expense.title
        cell.detailTextLabel?.text = "\(expense.value)"
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.history.value[section].first!.date.format(with: "MMM yyyy")
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}
}
