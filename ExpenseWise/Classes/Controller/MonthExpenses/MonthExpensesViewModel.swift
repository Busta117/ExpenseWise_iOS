//
//  MonthExpensesViewModel.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/8/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm

class MonthExpensesViewModel {
    var disposeBag = DisposeBag()

    var categories = Variable<[(category: Category, total: Float)]>([])
    var expenses = Variable<[Expense]>([])
    var total = Variable<Float>(0)

    var date: Date

    init(date: Date) {
        self.date = date
        dataBinding()
    }

    func dataBinding() {
        Expense.allByMonth(date: date).subscribe(onNext: { expenses in
            self.expenses.value = expenses.sorted(by: ({ $0.date > $1.date }))
            self.filterCategories()
            self.setTotal()
        }).disposed(by: disposeBag)
    }

    func setTotal() {
        expenses.value.forEach({ total.value = total.value + $0.value })
    }

    func filterCategories() {
//        expenses.value.forEach { expense in
//            print(expense.title)
//            var cat = Category.by(id: 0)
//            print(cat?.name)
//            expense.update({ (exp: Expense) in
//                print("cosa")
//            })
//            print(expense.category?.name)
//        }

        var totalByCat = [(category: Category, total: Float)]()

        Category.all.forEach { category in
            var total: Float = 0
            let filtered = expenses.value.filter({ $0.category?.id == category.id })
            if filtered.count > 0 {
                _ = filtered.map({ total = total + $0.value })
                if total > 0 {
                    totalByCat.append((category: category, total: total))
                }
            }
        }
        categories.value = totalByCat
    }
}
