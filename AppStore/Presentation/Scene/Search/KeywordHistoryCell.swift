//
//  KeywordHistoryCell.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import UIKit

final class KeywordHistoryCell: UITableViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        keywordLabel.text = ""
    }
}
