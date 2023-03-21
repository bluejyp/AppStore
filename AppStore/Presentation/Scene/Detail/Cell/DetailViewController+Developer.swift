//
//  DetailViewController+Developer.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import Foundation

extension DetailViewController {
    func updateDeveloper() {
        companyLabel.text = viewModel?.sellerName
        developerLabel.text = "개발자"
    }
}
