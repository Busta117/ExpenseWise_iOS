//
//  Expense.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import RxRealm
import RxSwift
import DateToolsSwift

class Expense: Object {
    enum PaymentMethod: String {
        case creditCard = "Credit Card"
        case cash = "Cash"
    }

    @objc dynamic var id: Int64 = 0
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
    @objc dynamic var value: Float = 0
    @objc fileprivate dynamic var paymentMethodStr = PaymentMethod.creditCard.rawValue
    var paymentMethod: PaymentMethod {
        set { paymentMethodStr = newValue.rawValue }
        get { return PaymentMethod(rawValue: paymentMethodStr)! }
    }

    @objc dynamic var category: Category?

    override static func primaryKey() -> String? {
        return "id"
    }

    class var last: Expense? {
        do {
            let realm = try Realm()
            let expenses = realm.objects(Expense.self)
            if let last = expenses.last {
                return last
            }
            return nil

        } catch _ {
            return nil
        }
    }

    class var all: Observable<[Expense]> {
        do {
            let realm = try Realm()
            let expenses = realm.objects(Expense.self)
            return Observable.array(from: expenses)

        } catch _ {
            fatalError("REALM Error: error getting the expenses")
        }
    }

    class func allByMonth(date: Date) -> Observable<[Expense]> {
        return expensesByMonth(date: date)
    }

    class func expensesByMonth(date: Date) -> Observable<[Expense]> {
        do {
            let realm = try Realm()
            let min = date.start(of: Component.month)
            let max = date.end(of: Component.month)
            let predicate = NSPredicate(format: "date >= %@ AND date <= %@", min as CVarArg, max as CVarArg)
            let expenses = realm.objects(Expense.self).filter(predicate)
            return Observable.array(from: expenses)

        } catch _ {
            fatalError("REALM Error: error getting the expenses")
        }
    }
}
