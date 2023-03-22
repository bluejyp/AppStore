//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var downLoadCountLabel: UILabel!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var thumbImgViewFirst: UIImageView!
    @IBOutlet weak var thumbImgViewSecond: UIImageView!
    @IBOutlet weak var thumbImgViewThird: UIImageView!
    
    private lazy var cosmosRatingView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.frame = CGRect(x: 0,
                              y: 0,
                              width: ratingContainerView.frame.size.width,
                              height: ratingContainerView.frame.size.height)
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyBorderColor = UIColor.darkGray
        cosmos.settings.totalStars = 5
        cosmos.settings.starSize = 10
        cosmos.settings.fillMode = .full
        cosmos.settings.filledBorderColor = UIColor.darkGray
        cosmos.settings.filledColor = UIColor.darkGray
        ratingContainerView.addSubview(cosmos)
        
        return cosmos
    }()
    
    var viewModel: SearchResultCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            titleLabel.text = viewModel.title
            subTitleLabel.text = viewModel.subtitle
            downLoadCountLabel.text = viewModel.ratingCount
            cosmosRatingView.rating = viewModel.rating
            
            iconImgView.setImage(urlStrig: viewModel.iconImageUrlString)
            thumbImgViewFirst.setImage(urlStrig: viewModel.screenshotImage1Url)
            thumbImgViewSecond.setImage(urlStrig: viewModel.screenshotImage2Url)
            thumbImgViewThird.setImage(urlStrig: viewModel.screenshotImage3Url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        downBtn.setTitle("받기", for: .normal)
    }
}
