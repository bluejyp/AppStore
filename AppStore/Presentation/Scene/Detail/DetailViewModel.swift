//
//  DetailViewModel.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/18.
//

import Foundation

class DetailViewModel {
    var appInfo: AppInfo
    
    init(info: AppInfo) {
        appInfo = info
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
    
    

    
}

extension DetailViewModel {
    var icon512ImageUrlString: String {
        appInfo.artworkUrl512
    }
    
    var trackName: String {
        appInfo.trackName ?? ""
    }
    
    var subtitle: String {
        appInfo.genres?.first ?? ""
    }
}

extension DetailViewModel {
    var version: String? {
        appInfo.version
    }
    
    var releaseDate: String? {
        appInfo.releaseDate
    }
    
    var releaseNote: String? {
        appInfo.releaseNotes
    }
}

extension DetailViewModel {
    var screenshotUrls: [String]? {
        appInfo.screenshotUrls
    }
}


extension DetailViewModel {
    
}


extension DetailViewModel {
    
}


extension DetailViewModel {
    
}

