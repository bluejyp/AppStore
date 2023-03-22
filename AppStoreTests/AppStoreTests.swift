//
//  AppStoreTests.swift
//  AppStoreTests
//
//  Created by Jinyoung on 2023/03/18.
//

import XCTest
import RxSwift
@testable import AppStore

final class AppStoreTests: XCTestCase {
   
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws { }
    override func tearDownWithError() throws { }
    
    func testSearchResultViewModel_ReturnNotNil() {
        let viewModel = SearchResultViewModel(searchResultUseCase: MockSearchResultUseCase(mockResponse: "MockAPIResponse"))
        let input = SearchResultViewModel.Input(keyword: Observable.just("카카오"))
        let output = viewModel.transform(input: input)
        
        output.searchResultList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {  result in
                switch result {
                case .success(let data):
                    XCTAssertTrue(data.count == 10)
                    break
                case .failure(let error):
                    print("error \(error)")
                    XCTAssert(false)
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func testSearchResultViewModel_ParsingAppInfo() {
        let viewModel = SearchResultViewModel(searchResultUseCase: MockSearchResultUseCase(mockResponse: "MockAPIResponse2"))
        let input = SearchResultViewModel.Input(keyword: Observable.just("카카오"))
        let output = viewModel.transform(input: input)
        
        output.searchResultList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let data):
                    guard let info = data.first as? AppInfo else {
                        XCTAssert(false)
                        return
                    }
                    XCTAssertTrue(data.count == 1)
                    XCTAssertTrue(info.trackName == "카카오톡 KakaoTalk")
                    XCTAssertTrue(info.sellerName == "Kakao Corp.")
                    break
                case .failure(let error):
                    print("error \(error)")
                    XCTAssert(false)
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
