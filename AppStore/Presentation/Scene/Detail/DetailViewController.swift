//
//  DetailViewController.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/18.
//

import UIKit

enum DetailTableRowInfo: Int {
    case titleContents = 0
    case rating
    case releaseInfo
    case screenshot
    case description
    case developer
    
    var indexPath: IndexPath {
        IndexPath(row: self.rawValue, section: 0)
    }
}

class DetailViewController: UITableViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    // Rating Cell
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var ratingAgeLabel: UILabel!
    @IBOutlet weak var ratingChartValueLabel: UILabel!
    @IBOutlet weak var ratingCompnayLabel: UILabel!
    @IBOutlet weak var ratingLanguageLabel: UILabel!
    @IBOutlet weak var ratingLanguageInfoLabel: UILabel!
    
    // ReleaseInfo Cell
    @IBOutlet weak var releaseNoteTitleLabel: UILabel!
    @IBOutlet weak var releaseVersionButton: UIButton!
    @IBOutlet weak var releaseVersionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    @IBOutlet weak var releaseNoteMoreButton: UIButton!
    
    // screenShot Cell
    @IBOutlet weak var screenShotStackView: UIStackView!
    
    // description Cell
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionMoreButton: UIButton!
    
    // developer Cell
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        configureUI()
    }
    
    private func configureUI() {
        updateTitleContents()
        updateNewFunction()
        updateScreenshot()
        updateDescription()
        updateDeveloper()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}





