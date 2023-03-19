//
//  AppInfo.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation

struct SearchResponseModel: Codable {
    var resultCount: Int?
    var results: [AppInfo]?
}

public struct AppInfo: RawDataProtocol {
    var ipadScreenshotUrls: [String]?
    var appletvScreenshotUrls: [String]?
    var artworkUrl60: String?
    var artworkUrl512: String?
    var artworkUrl100: String?
    var artistViewUrl: String?
    var screenshotUrls: [String]?
    var feature: [String]? //TODO 더 알아봐야함 형식을 알 수 없음.
    var supportedDevices: [String]?
    var advisories: [String]?
    var isGameCenterEnabled: Bool?
    var kind: String?
    var minimumOsVersion: String?
    var trackCensoredName: String?
    var languageCodesISO2A: [String]?
    var fileSizeBytes: String?
    var formattedPrice: String?
    var contentAdvisoryRating: String?
    var averageUserRatingForCurrentVersion: Double?
    var userRatingCountForCurrentVersion: Double?
    var trackViewUrl: String?
    var trackContentRating: String?
    var averageUserRating: Double?
    var bundleId: String?
    var releaseDate: String?
    var trackId: Float?
    var trackName: String?
    var sellerName: String?
    var primaryGenreName: String?
    var genreIds: [String]?
    var isVppDeviceBasedLicensingEnabled: Bool?
    var currentVersionReleaseDate: String?
    var releaseNotes: String?
    var z: Double?
    var currency: String?
    var version: String?
    var wrapperType: String?
    var artistId: Double?
    var artistName: String?
    var genres: [String]?
    var price: Float?
    var description: String?
    var userRatingCount: Double?
    
}
