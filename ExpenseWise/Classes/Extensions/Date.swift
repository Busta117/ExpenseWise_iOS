//
//  Date.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import DateToolsSwift

extension Date {
    func isSameMonth(date: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        var components = calendar.dateComponents([.era, .year, .month], from: self)
        let dateOne = calendar.date(from: components)

        components = calendar.dateComponents([.era, .year, .month], from: date)
        let dateTwo = calendar.date(from: components)

        return (dateOne?.equals(dateTwo!))!
    }
}
