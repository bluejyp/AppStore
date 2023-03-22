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
    var searchRepository: SearchRepositoryInterface
   
    init(repository: SearchRepositoryInterface) {
        searchRepository = repository
    }
    
    var keywordHistory: BehaviorRelay<[String]> {
        searchRepository.keywordHistory
    }
    
    func save(keyworkd: String) {
        searchRepository.save(keyword: keyworkd)
    }
}

