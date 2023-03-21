//
//  DetailViewController+ScreenShot.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import UIKit

extension DetailViewController {
    func updateScreenshot() {
        viewModel?.screenshotUrls?.forEach({ urlString in
            addScreenshotImageView(urlSring: urlString)
        })
    }
    
    func addScreenshotImageView(urlSring: String) {
        let imageView = UIImageView(frame: .zero)
        imageView.setImage(urlStrig: urlSring)
        imageView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 210).isActive = true
        
        screenShotStackView.addArrangedSubview(imageView)
    }
}
