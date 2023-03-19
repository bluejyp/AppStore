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
    var recentlyKeywordList: BehaviorRelay<[String]> { get set }
    
    func fetchRecentlyKeyworkdList() -> Observable<[String]>
    func save(keyword: String)
}
