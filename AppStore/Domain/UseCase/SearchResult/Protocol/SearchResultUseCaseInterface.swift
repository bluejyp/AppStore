//
//  SearchResultUseCaseInterface.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation
import RxSwift

protocol RawDataProtocol: Codable {
    
}

enum SearchError: Error {
    case EmptyKeywordError
    case parsingError
    case responseError
    case mockdataError
    case unkownError
}

typealias SearchResult = Result<[RawDataProtocol], SearchError>

protocol SearchResultUseCaseInterface {
    func searchResultList(keyword: String) -> Observable<SearchResult>
}
