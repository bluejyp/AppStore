//
//  SearchUseCase.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

final class SearchUseCase: SearchUseCaseInterface {
    private let searchRepository = SearchRepository()
    var recentlyKeyworkdList: ReplaySubject<[String]> {
        searchRepository.recentlyKeywordList
    }
    
    func save(keyworkd: String) {
        searchRepository.save(keyword: keyworkd)
    }
}

