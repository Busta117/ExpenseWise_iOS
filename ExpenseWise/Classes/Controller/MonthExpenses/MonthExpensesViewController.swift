//
//  MonthExpensesViewController.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/8/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm
import DateToolsSwift

class MonthExpensesViewController: BaseViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var totalPaidLabel: UILabel!
    @IBOutlet var thisMonthTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    var viewModel: MonthExpensesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    override func configureAppereance() {
        super.configureAppereance()

        title = viewModel.date.format(with: "MMMM yyyy")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ADD", style: UIBarButtonItem.Style.done, target: self, action: #selector(addNewExpense))
    }

    override func dataBinding() {
        super.dataBinding()

        viewModel.categories.asObservable().subscribe(onNext: { cats in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.expenses.asObservable().subscribe(onNext: { expenses in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.total.asObservable().subscribe(onNext: { newTotal in
            self.totalPaidLabel.text = newTotal.currencyValue
        }).disposed(by: disposeBag)
    }

    func registerCell() {
        tableView.register(UINib(nibName: "ExpenseDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpenseDetailTableViewCell")
    }

    @objc func addNewExpense() {
        navigationController?.pushViewController(AddExpenseViewController.launch(), animated: true)
    }
}

extension MonthExpensesViewController {
    class func launch(date: Date) -> MonthExpensesViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MonthExpensesViewController") as! MonthExpensesViewController
        vc.viewModel = MonthExpensesViewModel(date: date)
        return vc
    }
}

extension MonthExpensesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expenses.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseDetailTableViewCell", for: indexPath) as! ExpenseDetailTableViewCell
        cell.setup(expense: viewModel.expenses.value[indexPath.row])
        return cell
    }
}

extension MonthExpensesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthExpenseCategotyTotalCollectionViewCell", for: indexPath) as! MonthExpenseCategotyTotalCollectionViewCell
        cell.setup(category: viewModel.categories.value[indexPath.row].category, total: viewModel.categories.value[indexPath.row].total)
        return cell
    }
}
