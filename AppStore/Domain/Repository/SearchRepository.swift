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
    var recentlyKeywordList: BehaviorRelay<[String]>
    
    init() {
        let fetchedlist = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        recentlyKeywordList = BehaviorRelay<[String]>(value: fetchedlist ?? [])
    }

    func fetchRecentlyKeywordList() {
        let fetchedlist = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        recentlyKeywordList.accept(fetchedlist ?? [])
//        onNext(fetchedlist ?? [])
//        return Observable.of(fetchedlist ?? [])
    }
    
    func save(keyword: String) {
        var recentlyKeywordList = UserDefaults.standard.object(forKey: "RecntlyKeywordList") as? [String]
        if recentlyKeywordList == nil {
            recentlyKeywordList = [String]()
        }
     
        recentlyKeywordList?.append(keyword)
        
        self.recentlyKeywordList.accept(recentlyKeywordList ?? [])
//        self.recentlyKeywordList.onNext(recentlyKeywordList ?? [])
        UserDefaults.standard.set(recentlyKeywordList, forKey: "RecntlyKeywordList")
    }
}
