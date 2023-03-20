//
//  SearchRepository.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchRepository: SearchRepositoryInterface {    
    var recentlyKeywordList: ReplaySubject<[String]> = ReplaySubject<[String]>.create(bufferSize: 1)

//    @discardableResult
    func fetchRecentlyKeywordList() {
        let fetchedlist = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        recentlyKeywordList.onNext(fetchedlist ?? [])
//        return Observable.of(fetchedlist ?? [])
    }
    
    func save(keyword: String) {
        var recentlyKeywordList = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        if recentlyKeywordList == nil {
            recentlyKeywordList = [String]()
        }
     
        recentlyKeywordList?.append(keyword)
        self.recentlyKeywordList.onNext(recentlyKeywordList ?? [])
        UserDefaults.standard.set(recentlyKeywordList, forKey: "RecntlyKeywordList")
    }
}
