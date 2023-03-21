//
//  SearchRepositoryInterface.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchRepositoryInterface {
    var keywordHistory: BehaviorRelay<[String]> { get set }
    
    func fetchKeywordHistory()
    func save(keyword: String)
}
