//
//  DetailViewModel.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/18.
//

import Foundation

class DetailViewModel {
    internal var appInfo: AppInfo
    
    init(info: AppInfo) {
        appInfo = info
    }
}

/// title
extension DetailViewModel {
    var icon512ImageUrlString: String {
        appInfo.artworkUrl512
    }
    
    var trackName: String {
        appInfo.trackName
    }
    
    var subtitle: String {
        appInfo.genres?.first ?? ""
    }
}

/// rating
extension DetailViewModel {
    var rating: Double {
        Double(appInfo.averageUserRatingForCurrentVersion ?? 0)
    }

    var ratingCount: String {
        guard let count = appInfo.userRatingCountForCurrentVersion else {
            return "0"
        }
        
        return String(format:"%0.0f", count)
    }
    
    var trackContentRating: String? {
        appInfo.trackContentRating
    }
    
    var genre: String? {
        appInfo.genres?.first
    }
    
    var supportLanguage: String? {
        appInfo.languageCodesISO2A?.first ?? "KO"
    }
    
    var language: String? {
        guard let languages = appInfo.languageCodesISO2A else {
            return ""
        }
        
        if languages.count > 1 {
            let count = languages.count - 1
            if count > 0 {
                return "+\(count)개 언어"
            }
        } else {
            let locale = NSLocale(localeIdentifier: "KO")
            let code = languages.first ?? "KO"
            return locale.displayName(forKey: .identifier, value: code) ?? ""
        }
        
        return ""
    }
}


/// Release Note
extension DetailViewModel {
    var version: String? {
        appInfo.version
    }
    
    var releaseDate: String? {
        guard let currentReleaseDate = appInfo.currentVersionReleaseDate else {
            return appInfo.currentVersionReleaseDate
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = dateFormatter.date(from: currentReleaseDate) else {
            return currentReleaseDate
        }
        
        dateFormatter.dateFormat = "yyyy년 M월"
        
        return dateFormatter.string(from: date)
    }
    
    var releaseNote: String? {
        appInfo.releaseNotes
    }
}


/// Screenshot
extension DetailViewModel {
    var screenshotUrls: [String]? {
        appInfo.screenshotUrls
    }
}

/// Description
extension DetailViewModel {
    var description: String? {
        appInfo.description
    }
}

/// Developer
extension DetailViewModel {
    var sellerName: String? {
        appInfo.sellerName
    }
}
