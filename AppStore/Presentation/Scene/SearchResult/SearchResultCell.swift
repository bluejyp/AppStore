//
//  SearchResultCell.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var itemInfo: AppInfo? {
        didSet {
            titleLabel.text = itemInfo?.trackName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
