//
//  ContentTableViewCell.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet private var titile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(usingViewModel viewModel: ContentCellViewModel) {
        titile.text = viewModel.title
    }
    
    
}
