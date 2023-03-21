//
//  SearchResultCellViewModel.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import Foundation

final class SearchResultCellViewModel {
    let appInfo: AppInfo
    
    init(info: AppInfo) {
        appInfo = info
    }
    var title: String {
        appInfo.trackName
    }
    
    var subtitle: String {
        appInfo.genres?.first ?? ""
    }
    
    var bundleId: String {
        appInfo.bundleId ?? ""
    }
    
    var rating: Double {
        Double(appInfo.averageUserRatingForCurrentVersion ?? 0)
    }

    var ratingCount: String {
        guard let count = appInfo.userRatingCountForCurrentVersion else {
            return "0"
        }
        
        return String(format:"%0.0f", count)
    }
    var iconImageUrlString: String {
        appInfo.artworkUrl100
    }

    var screenshotImage1Url: String {
        guard let screenShoutUrls = appInfo.screenshotUrls,
                screenShoutUrls.indices.contains(0) else {
            return ""
        }

        return screenShoutUrls[0]
        
    }

    var screenshotImage2Url: String {
        guard let screenShoutUrls = appInfo.screenshotUrls,
                screenShoutUrls.indices.contains(1) else {
            return ""
        }

        return screenShoutUrls[1]
        
    }
    
    var screenshotImage3Url: String {
        guard let screenShoutUrls = appInfo.screenshotUrls,
                screenShoutUrls.indices.contains(2) else {
            return ""
        }

        return screenShoutUrls[2]
        
    }
}
