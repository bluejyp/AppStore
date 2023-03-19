//
//  SearchViewModel.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/18.
//

import Foundation
import RxSwift

class SearchViewModel: ViewModelBase {
    let searchUseCase = SearchUseCase()
    let disposeBag = DisposeBag()
   
    struct Input {
        var keyword: Observable<String>
    }
    
    struct Output {
        var recentlyKeywordList: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        input.keyword.subscribe { keyword in
            self.searchUseCase.save(keyworkd: keyword)
        }
        .disposed(by: disposeBag)
        
        let observable = searchUseCase.recentlyKeyworkdList()
        return Output(recentlyKeywordList: observable)
    }
}
