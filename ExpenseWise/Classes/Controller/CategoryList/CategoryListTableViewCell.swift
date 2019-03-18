//
//  CategoryListTableViewCell.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 2/6/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

class CategoryListTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(category: Category) {
        titleLabel.text = category.name
    }
}
