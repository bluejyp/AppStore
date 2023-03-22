//
//  MockSearchResultUseCase.swift
//  AppStoreTests
//
//  Created by 박진영 on 2023/03/22.
//

import Foundation
import RxSwift
@testable import AppStore

class MockSearchResultUseCase: SearchResultUseCaseInterface {
    let mockResponse: String
    
    init(mockResponse: String) {
        self.mockResponse = mockResponse
    }
    
    func searchResultList(keyword: String) -> Observable<AppStore.SearchResult> {
        guard let path = Bundle.main.path(forResource: self.mockResponse, ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
            print("Error")
            return Observable.just(SearchResult.failure(.mockdataError))
        }

        guard let data = jsonString.data(using: .utf8) else{
            return Observable.just(SearchResult.failure(.parsingError))
        }
        
        let dataModel = try? JSONDecoder().decode(SearchResponseModel.self, from: data)
        if dataModel != nil,
            let appData = dataModel?.results {
            return Observable.just(SearchResult.success(appData))
        }
        
        return Observable.just(SearchResult.failure(.unkownError))
    }
}
