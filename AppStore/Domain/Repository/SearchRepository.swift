//
//  SearchRepository.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchRepository: SearchRepositoryInterface {
    var keywordHistory: BehaviorRelay<[String]>
    
    init() {
        let fetchedlist = UserDefaults.standard.object(forKey: "KeywordHistory") as? [String]
        keywordHistory = BehaviorRelay<[String]>(value: fetchedlist ?? [])
    }

    func fetchKeywordHistory() {
        let fetchedlist = UserDefaults.standard.object(forKey: "KeywordHistory") as? [String]
        keywordHistory.accept(fetchedlist ?? [])
    }
    
    func save(keyword: String) {
        guard keyword.count > 0 else { return }
        
        var historyList = UserDefaults.standard.object(forKey: "KeywordHistory") as? [String]
        
        if historyList == nil {
            historyList = [String]()
        }
        
        if let list = historyList,
           list.contains(keyword) {
            historyList = list.filter({ $0 != keyword})
        }

        historyList?.insert(keyword, at: 0)
        UserDefaults.standard.set(historyList, forKey: "KeywordHistory")
        UserDefaults.standard.synchronize()
        keywordHistory.accept(historyList ?? [])
    }
}
