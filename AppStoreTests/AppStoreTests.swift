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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
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
