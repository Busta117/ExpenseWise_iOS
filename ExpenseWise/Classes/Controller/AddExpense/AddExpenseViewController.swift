//
//  AddExpenseViewController.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import SBPickerSelector
import DateToolsSwift

class AddExpenseViewController: BaseViewController {
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var creditCardButton: UIButton!
    @IBOutlet var cashButton: UIButton!

    var viewModel = AddExpenseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextField.becomeFirstResponder()
    }

    override func configureAppereance() {
        super.configureAppereance()
        title = "Add Expense"

        viewModel.getCategories()
        dateButton.setTitle("Today", for: .normal)

        tableView.tableFooterView = UIView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(saveAction))

        registerNotifications()
    }

    func registerNotifications() {
        notificationManager.addObserver(forName: UIResponder.keyboardWillShowNotification) { notification in
            self.tableView.scrollIndicatorInsets.bottom = notification.keyboardHeight
            self.tableView.contentInset.bottom = notification.keyboardHeight
        }

        notificationManager.addObserver(forName: UIResponder.keyboardWillHideNotification) { notification in
            self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
            self.tableView.contentInset = UIEdgeInsets.zero
        }
    }

    @objc func saveAction() {
        guard descriptionTextField.text?.count ?? 0 > 0 else {
            print("you need to set a description")
            return
        }

        guard valueTextField.text?.count ?? 0 > 0 else {
            print("you need to set a value")
            return
        }

        guard viewModel.expense.category != nil else {
            print("you need to set a category")
            return
        }

        viewModel.expense.title = descriptionTextField.text!
        viewModel.expense.value = Float(valueTextField.text!)!

        viewModel.save()
        navigationController?.popViewController(animated: true)
    }

    @IBAction func dateAction(_ sender: Any) {
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.dateDayMonthYear).set { values in
            if let dates = values as? [Date], let date = dates.first {
                self.viewModel.expense.date = date
                if date.isToday {
                    self.dateButton.setTitle("Today", for: .normal)
                } else {
                    self.dateButton.setTitle(date.format(with: "MMMM dd, yyyy"), for: .normal)
                }
            }
        }.present(into: self)
    }

    @IBAction func paymentMethodAction(_ sender: UIButton) {
        if sender == creditCardButton {
            viewModel.expense.paymentMethod = .creditCard
            creditCardButton.backgroundColor = creditCardButton.backgroundColor?.withAlphaComponent(1)
            cashButton.backgroundColor = cashButton.backgroundColor?.withAlphaComponent(0.5)
        } else {
            viewModel.expense.paymentMethod = .cash
            creditCardButton.backgroundColor = creditCardButton.backgroundColor?.withAlphaComponent(0.5)
            cashButton.backgroundColor = cashButton.backgroundColor?.withAlphaComponent(1)
        }
    }
}

extension AddExpenseViewController {
    class func launch() -> AddExpenseViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddExpenseViewController") as! AddExpenseViewController
    }
}

extension AddExpenseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let category = viewModel.categories.value[indexPath.row]
        cell.textLabel?.text = category.name
        cell.selectionStyle = .none
        cell.accessoryType = .none
        if let selectedCat = viewModel.expense.category, selectedCat.id == category.id {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.categories.value[indexPath.row]
        viewModel.expense.category = category
        tableView.reloadData()
    }
}
