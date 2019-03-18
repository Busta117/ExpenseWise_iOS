//
//  CategoryListViewModel.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class CategoryListViewModel {
    var disposeBag = DisposeBag()

    var categories = Variable<[Category]>([])
    var totalMonth = Variable<Float>(0)

    init() {
        dataBinding()
    }

    func dataBinding() {
        Category.allObservable.subscribe(onNext: { categoryList in
            self.categories.value = categoryList
        }).disposed(by: disposeBag)

        Expense.expensesByMonth(date: Date()).subscribe(onNext: { expenses in
            var total: Float = 0
            _ = expenses.map({ total += $0.value })
            self.totalMonth.value = total
        }).disposed(by: disposeBag)
    }
}
