//
//  SearchResultUseCase.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

class SearchResultUseCase: SearchResultUseCaseInterface {
    func searchResultList(keyword: String) -> Observable<SearchResult> {
        let request = SearchAppListConfig(keyworkd: keyword).request()
        
        return NetworkService.shared.requestSend(request: request).map { result -> SearchResult in
            switch result {
            case .success(let data):
                if let resultData = data {
                    do {
                        let model = try JSONDecoder().decode(SearchResponseModel.self, from: resultData)
                        return SearchResult.success(model.results ?? [])
                    }catch let error {
                        print("error = \(error)")
                        return SearchResult.failure(.parsingError)
                    }
                } else {
                    return SearchResult.success([])
                }
            case .failure(let error):
                print("error \(error)")
                return SearchResult.failure(.responseError)
            }
        }
    }
}
