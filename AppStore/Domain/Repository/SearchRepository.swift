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
    private let KEYWORD_HISTORY = "KeywordHistory"
    var keywordHistory: BehaviorRelay<[String]>
    
    init() {
        let fetchedlist = UserDefaults.standard.object(forKey: KEYWORD_HISTORY) as? [String]
        keywordHistory = BehaviorRelay<[String]>(value: fetchedlist ?? [])
    }

    func fetchKeywordHistory() {
        let fetchedlist = UserDefaults.standard.object(forKey: KEYWORD_HISTORY) as? [String]
        keywordHistory.accept(fetchedlist ?? [])
    }
    
    func save(keyword: String) {
        guard keyword.count > 0 else { return }
        
        var historyList = UserDefaults.standard.object(forKey: KEYWORD_HISTORY) as? [String]
        
        if historyList == nil {
            historyList = [String]()
        }
        
        if let historyList = historyList,
            historyList.contains(keyword) {
            return
        }
        
        historyList?.append(keyword)
        UserDefaults.standard.set(historyList, forKey: KEYWORD_HISTORY)
        keywordHistory.accept(historyList ?? [])
    }
}
