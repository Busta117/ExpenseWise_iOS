//
//  Category.swift
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

class Category: Object {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int64, name: String) {
        self.init()
        self.id = id
        self.name = name
    }

    class var allObservable: Observable<[Category]> {
        do {
            let realm = try Realm()
            let categories = realm.objects(Category.self)
            return Observable.array(from: categories)

        } catch _ {
            fatalError("REALM Error: error getting the catorgies")
        }
    }

    class func by(id: Int64) -> Category? {
        do {
            let realm = try Realm()
            let categories = realm.objects(Category.self).filter(NSPredicate(format: "id == %d", id))
            return categories.first

        } catch _ {
            fatalError("REALM Error: error getting the categories")
        }
    }

    class var all: [Category] {
        do {
            let realm = try Realm()
            let categories = realm.objects(Category.self)
            return Array(categories)

        } catch _ {
            fatalError("REALM Error: error getting the categories")
        }
    }

    class func create() {
        Category(id: 0, name: "Bills").save()
        Category(id: 1, name: "Groceries").save()
        Category(id: 2, name: "Transportation").save()
        Category(id: 3, name: "Food").save()
        Category(id: 4, name: "Leisure and Entertainment").save()
        Category(id: 5, name: "Travel").save()
        Category(id: 6, name: "Pets").save()
        Category(id: 7, name: "Beauty").save()
        Category(id: 8, name: "Health").save()
    }
}
