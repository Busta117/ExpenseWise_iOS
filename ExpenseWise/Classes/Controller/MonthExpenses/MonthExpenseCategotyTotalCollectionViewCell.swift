//
//  MonthExpenseCategotyTotalCollectionViewCell.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/8/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class MonthExpenseCategotyTotalCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    func setup(category: Category, total: Float) {
        titleLabel.text = category.name
        valueLabel.text = total.currencyValue
    }
}
