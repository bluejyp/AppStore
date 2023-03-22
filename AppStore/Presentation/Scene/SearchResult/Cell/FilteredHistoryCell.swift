//
//  FilteredHistoryCell.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/22.
//

import UIKit

class FilteredHistoryCell: UITableViewCell {
    @IBOutlet weak var keywordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        keywordLabel.text = ""
    }
}
