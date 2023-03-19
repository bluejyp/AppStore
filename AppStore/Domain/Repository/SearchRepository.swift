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
    
    @discardableResult
    func fetchRecentlyKeyworkdList() -> RxSwift.Observable<[String]> {
        let fetchedlist = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        return Observable.of(fetchedlist ?? [])
    }
    
    func save(keyword: String) {
        var recentlyKeywordList = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        if recentlyKeywordList == nil {
            recentlyKeywordList = [String]()
        }
     
        recentlyKeywordList?.append(keyword)
        
        UserDefaults.standard.set(recentlyKeywordList, forKey: "RecntlyKeywordList")
    }
}
