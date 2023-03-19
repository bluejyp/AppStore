//
//  SearchUseCase.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

final class SearchUseCase: SearchUseCaseInterface {
    let searchRepository = SearchRepository()
    
    func recentlyKeyworkdList() -> BehaviorRelay<[String]> {
        searchRepository.emit()
        return searchRepository.recentlyKeywordList
        
    }
    
    func save(keyworkd: String) {
        searchRepository.save(keyword: keyworkd)
    }
}

