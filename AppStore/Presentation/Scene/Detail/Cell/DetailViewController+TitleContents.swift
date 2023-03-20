//
//  DetailViewController+TitleContents.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import Foundation

extension DetailViewController {
    func updateTitleContents() {
        titleLabel.text = viewModel?.trackName
        subTitleLabel.text = viewModel?.subtitle
        
        if let imageUrl = viewModel?.icon512ImageUrlString {
            iconImageView.setImage(urlStrig: imageUrl)
        }
    }
}
