//
//  CategoryListViewController.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class CategoryListViewController: BaseViewController {
    @IBOutlet var addExpenseButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentMonthTotalLabel: UILabel!

    var viewModel = CategoryListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureAppereance() {
        super.configureAppereance()
        title = "Expense Wise"

        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    override func dataBinding() {
        super.dataBinding()
        viewModel.categories.asObservable().subscribe(onNext: { cats in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.totalMonth.asObservable().subscribe(onNext: { total in

            if let formattedAmount = total.currencyValue {
                self.currentMonthTotalLabel.text = formattedAmount
            }

        }).disposed(by: disposeBag)
    }

    @IBAction func currentMonthDetailAction(_ sender: Any) {
        navigationController?.pushViewController(MonthExpensesViewController.launch(date: Date()), animated: true)
    }

    @IBAction func addExpenseAction(_ sender: Any) {
        navigationController?.pushViewController(AddExpenseViewController.launch(), animated: true)
    }
}

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell", for: indexPath) as! CategoryListTableViewCell
        let category = viewModel.categories.value[indexPath.row]
        cell.setup(category: category)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
}

extension CategoryListViewController {
    class func launch() -> CategoryListViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryListViewController") as! CategoryListViewController
    }
}
