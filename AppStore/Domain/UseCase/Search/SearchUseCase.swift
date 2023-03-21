//
//  SearchUseCase.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchUseCase: SearchUseCaseInterface {
    private let searchRepository = SearchRepository()
   
    var keywordHistory: BehaviorRelay<[String]> {
        searchRepository.keywordHistory
    }
    
    func save(keyworkd: String) {
        searchRepository.save(keyword: keyworkd)
    }
}

