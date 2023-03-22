//
//  SearchResultUseCase.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

final class SearchResultUseCase: SearchResultUseCaseInterface {
    func searchResultList(keyword: String) -> Observable<SearchResult> {
        let request = SearchResultConfigurable(keyworkd: keyword).request()
        
        return NetworkService.shared.requestSend(request: request).map { result -> SearchResult in
            switch result {
            case .success(let data):
                if let resultData = data {
                    do {
                        let model = try JSONDecoder().decode(SearchResponseModel.self, from: resultData)
                        return .success(model.results ?? [])
                    } catch {
                        return .failure(.parsingError)
                    }
                } else {
                    return .success([])
                }
            case .failure(_):
                return .failure(.responseError)
            }
        }
    }
}
