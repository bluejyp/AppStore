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
    func fetchRecentlyKeyworkdList() -> Observable<[String]>
    func save(keyword: String)
}
