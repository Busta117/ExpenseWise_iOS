//
//  dbMigration.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

import Realm
import RealmSwift

let newDBVersion: UInt64 = 4

class dbMigration {
    class func migrate() {
        realmMigration()
    }

    private class func realmMigration() {
        guard Realm.Configuration.defaultConfiguration.schemaVersion != newDBVersion else {
            print("REALM Database Version: \(Realm.Configuration.defaultConfiguration.schemaVersion)")
            // db updated
            return
        }

        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in

            if oldSchemaVersion < 4 {
                self.migrateV4(migration, oldSchemaVersion: oldSchemaVersion)
            }

            print("Realm migration complete from v\(oldSchemaVersion) to v\(newDBVersion)")
        }

        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: newDBVersion, migrationBlock: migrationBlock)
    }

    private class func migrateV4(_ migration: Migration, oldSchemaVersion: UInt64) {
        migration.enumerateObjects(ofType: Expense.className()) { oldObject, newObject in
            newObject?["paymentMethodStr"] = "Credit Card"
        }
    }
}
