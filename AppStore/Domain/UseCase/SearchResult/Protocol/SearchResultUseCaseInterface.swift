//
//  SearchResultUseCaseInterface.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

enum SearchError: Error {
    case emptyKeywordError
    case parsingError
    case responseError
    case mockdataError
    case unkownError
}

typealias SearchResult = Result<[RawDataProtocol], SearchError>

protocol SearchResultUseCaseInterface {
    func searchResultList(keyword: String) -> Observable<SearchResult>
}
