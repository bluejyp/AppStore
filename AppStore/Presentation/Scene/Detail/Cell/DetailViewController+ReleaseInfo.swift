//
//  DetailViewController+NewFunction.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import Foundation

extension DetailViewController {
    func updateReleaseInfo() {
        releaseNoteTitleLabel.text = "새로운 기능"
        releaseVersionButton.setTitle("버전 기록", for: .normal)
        releaseNoteMoreButton.setTitle("더보기", for: .normal)
        
        releaseVersionLabel.text = viewModel?.version
        releaseDateLabel.text = viewModel?.releaseDate
        releaseNoteLabel.text = viewModel?.releaseNote
     
        checkReleaseNote()
    }
    
    private func checkReleaseNote() {
        releaseNoteLabel.sizeToFit()
        checkReleaseNoteHeight(needDecrease: releaseNoteLabel.bounds.height > 55)
    }
    
    private func checkReleaseNoteHeight(needDecrease: Bool) {
        releaseNoteMoreButton.isHidden = !needDecrease
        
        if needDecrease {
            releaseNoteLabel.numberOfLines = 3
        } else {
            releaseNoteLabel.numberOfLines = 0
        }
    }
    
    @IBAction func didSelectReleaseMoreButton() {
        checkReleaseNoteHeight(needDecrease: false)
        
        tableView.reloadData()
//        tableView.performBatchUpdates(nil)
        
    }
}
