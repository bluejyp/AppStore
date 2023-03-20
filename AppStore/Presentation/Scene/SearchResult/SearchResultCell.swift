//
//  SearchResultCell.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultCell: UITableViewCell, OpenOtherApplication {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var downLoadCountLabel: UILabel!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var thumbImgViewFirst: UIImageView!
    @IBOutlet weak var thumbImgViewSecond: UIImageView!
    @IBOutlet weak var thumbImgViewThird: UIImageView!
    
    var viewModel: SearchResultCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            subTitleLabel.text = viewModel.subtitle
            downLoadCountLabel.text = viewModel.ratingCount

            iconImgView.setImage(urlStrig: viewModel.iconImageUrlString)
            thumbImgViewFirst.setImage(urlStrig: viewModel.screenshotImage1Url)
            thumbImgViewSecond.setImage(urlStrig: viewModel.screenshotImage2Url)
            thumbImgViewThird.setImage(urlStrig: viewModel.screenshotImage3Url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        downBtn.setTitle("받기", for: .normal)
    }
    
}
