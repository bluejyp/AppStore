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
    
    func recentlyKeyworkdList() -> Observable<[String]> {
        searchRepository.fetchRecentlyKeyworkdList()
    }
    
    func save(keyworkd: String) {
        searchRepository.save(keyword: keyworkd)
    }
}

