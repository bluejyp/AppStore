//
//  DetailViewController+Rating.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import Foundation

extension DetailViewController {
    func updateRating() {
        let ratingCount = viewModel?.ratingCount ?? "0"
        let rating = viewModel?.rating ?? 0
        ratingCountLabel.text = "\(ratingCount)개의 평가"
        ratingValueLabel.text = String(format: "%.1f", rating)
        cosmosRatingView.rating = rating
        
        let contentRating = viewModel?.trackContentRating ?? "0"
        ratingAgeLabel.text = "\(contentRating)"
        
        ratingChartValueLabel.text = "#22"
        ratingLanguageLabel.text = viewModel?.supportLanguage
        ratingLanguageInfoLabel.text = viewModel?.language
    }
}
