//
//  HomeViewModel.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm
import DateToolsSwift

class HomeViewModel {
    var disposeBag = DisposeBag()

    var history = Variable<[[Expense]]>([])

    init() {
        dataBinding()
    }

    func dataBinding() {
        Expense.all.subscribe(onNext: { expenses in
            self.sort(expenses: expenses)
        }).disposed(by: disposeBag)
    }

    func sort(expenses expensesIn: [Expense]) {
        var expenses = expensesIn
        var expensesReturn = [[Expense]]()

        // get 1 for each month
        expenses.sort(by: { $0.date > $1.date })
        if let exp = expenses.first {
            var date = exp.date
            while true {
                let expes = expenses.filter({ $0.date.isSameMonth(date: date) })
                if expes.count == 0 {
                    break
                }
                expensesReturn.append(expes)
                date = date.subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 1, years: 0))
            }
        }

        history.value = expensesReturn
    }
}
