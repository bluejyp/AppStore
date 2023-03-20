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
    case newFunction
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
    
    // NewFunction Cell
    @IBOutlet weak var newFunctionTitleLabel: UILabel!
    @IBOutlet weak var versionButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    @IBOutlet weak var newMoreButton: UIButton!
    
    // screenShot Cell
    @IBOutlet weak var screenShotStackView: UIStackView!
    
    // description Cell
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionMoreButton: UIButton!
    
    // developer Cell
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    var viewModel: DetailViewModel? {
        didSet {
            updateTitleContents()
            updateNewFunction()
            updateScreenshot()
            updateDescription()
            updateDeveloper()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == DetailTableRowInfo.description.rawValue {
//            return 500
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}





