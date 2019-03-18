//
//  ExpenseDetailTableViewCell.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/8/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import DateToolsSwift

class ExpenseDetailTableViewCell: UITableViewCell {
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(expense: Expense) {
        categoryLabel.text = expense.category?.name
        dateLabel.text = expense.date.format(with: "EEEE dd")
        descriptionLabel.text = expense.title
        valueLabel.text = 0.currencyValue
        if let formattedAmount = expense.value.currencyValue {
            valueLabel.text = formattedAmount
        }
    }
}
