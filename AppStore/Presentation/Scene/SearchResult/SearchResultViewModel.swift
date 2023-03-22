//
//  SearchResultViewModel.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/18.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchResultViewModel: ViewModelBase {
    let searchResultUseCase: SearchResultUseCaseInterface
    let disposeBag = DisposeBag()

    struct Input {
        var keyword: Observable<String>
    }

    struct Output {
        var searchResultList: Observable<SearchResult>
    }

    init(searchResultUseCase: SearchResultUseCaseInterface) {
        self.searchResultUseCase = searchResultUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.keyword
            .distinctUntilChanged()
            .flatMapLatest { [weak self] keyword -> Observable<SearchResult> in
                guard let self = self else {
                    return .just(SearchResult.failure(.unkownError))
                }
                
                guard keyword.count > 0 else {
                    return .just(SearchResult.failure(.EmptyKeywordError))
                }
                
                return self.searchResultUseCase.searchResultList(keyword: keyword)
            }
        
        return Output(searchResultList: result)
    }
}
