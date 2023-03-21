//
//  DetailViewController+Description.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import Foundation

extension DetailViewController {
    func updateDescription() {
        descriptionLabel.text = viewModel?.description
        descriptionMoreButton.setTitle("더보기", for: .normal)
        
        checkDescription()
    }
    
    private func checkDescription() {
        descriptionLabel.sizeToFit()
        checkDescriptionCellHeight(needDecrease: descriptionLabel.bounds.height > 55)
    }
    
    private func checkDescriptionCellHeight(needDecrease: Bool) {
        descriptionMoreButton.isHidden = !needDecrease
        
        if needDecrease {
            descriptionLabel.numberOfLines = 3
        } else {
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBAction func didSelectDescriptionMoreButton() {
        checkDescriptionCellHeight(needDecrease: false)
        
        tableView.reloadData()
//        tableView.performBatchUpdates(nil)
        
    }
}
