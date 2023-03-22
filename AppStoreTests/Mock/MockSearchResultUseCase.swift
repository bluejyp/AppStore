//
//  MockSearchResultUseCase.swift
//  AppStoreTests
//
//  Created by Jinyoung on 2023/03/22.
//

import Foundation
import RxSwift
@testable import AppStore

class MockSearchResultUseCase: SearchResultUseCaseInterface {
    let mockResponseFileName: String
    
    init(mockResponseFileName: String) {
        self.mockResponseFileName = mockResponseFileName
    }
    
    func searchResultList(keyword: String) -> Observable<AppStore.SearchResult> {
        guard let path = Bundle.main.path(forResource: self.mockResponseFileName, ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
            return Observable.just(.failure(.mockdataError))
        }

        guard let data = jsonString.data(using: .utf8) else{
            return Observable.just(.failure(.parsingError))
        }
        
        let dataModel = try? JSONDecoder().decode(SearchResponseModel.self, from: data)
        if dataModel != nil,
            let appData = dataModel?.results {
            return Observable.just(.success(appData))
        }
        
        return Observable.just(.failure(.unkownError))
    }
}
