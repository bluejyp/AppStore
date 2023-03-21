//
//  SearchViewModel.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/18.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelBase {
    let searchUseCase = SearchUseCase()
    let disposeBag = DisposeBag()
   
    struct Input {
        var keyword: Observable<String>
        var currentKeyword: Observable<String>
    }
    
    struct Output {
        var recentlyKeywordList: BehaviorRelay<[String]>
        var filteredKeyWordHistory: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let filteredKeyWordHistory = input.currentKeyword
            .flatMapLatest { [weak self] keyword -> Observable<[String]> in
                let result = self?.searchUseCase.keywordHistory.value.filter({ $0.contains(keyword)})
                return .just(result ?? [])
            }

        input.keyword.subscribe { keyword in
            self.searchUseCase.save(keyworkd: keyword)
        }
        .disposed(by: disposeBag)
        
        let publish = searchUseCase.keywordHistory
        return Output(recentlyKeywordList: publish, filteredKeyWordHistory: filteredKeyWordHistory)
    }
}
