//
//  AddExpenseViewModel.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift

class AddExpenseViewModel {
    var categories = Variable<[Category]>([])
    var expense = Expense()

    func getCategories() {
        categories.value = Category.all
    }

    func save() {
        if let last = Expense.last {
            expense.id = last.id + 1
        } else {
            expense.id = 0
        }
        expense.save()
    }
}
