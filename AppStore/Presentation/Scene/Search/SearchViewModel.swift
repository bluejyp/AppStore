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
        var currneyKeyword: Observable<String>
    }
    
    struct Output {
        var recentlyKeywordList: BehaviorRelay<[String]>
        var filterHistory: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        input.currneyKeyword.subscribe { currentKeyword in
            let list = self.searchUseCase.recentlyKeyworkdList.value.map {
                $0.contains(currentKeyword)
            }
        }
        .disposed(by: disposeBag)
        let list = input.currneyKeyword
            .distinctUntilChanged()
            .flatMapLatest { [weak self] keyword -> Observable<[String]> in
                let list = self?.searchUseCase.recentlyKeyworkdList.value.filter({ $0.contains(keyword)})
                return .just(list ?? [])
            }
//        let result = input.searchApps
//            .distinctUntilChanged()
//            .flatMapLatest { [weak self] keyword -> Observable<SearchResult> in
//                guard let self = self else { return .just(SearchResult.failure(.unkownError))}
//                guard keyword.count > 0 else{
//                    return .just(SearchResult.failure(.keywordError))
//                }
//                return self.userCase.appLists(keyword: keyword)
//            }
        
        input.keyword.subscribe { keyword in
            self.searchUseCase.save(keyworkd: keyword)
        }
        .disposed(by: disposeBag)
        
        let publish = searchUseCase.recentlyKeyworkdList
        return Output(recentlyKeywordList: publish,filterHistory: list)
    }
}
