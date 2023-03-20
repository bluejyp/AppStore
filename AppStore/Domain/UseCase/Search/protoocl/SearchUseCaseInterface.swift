//
//  SearchUseCaseInterface.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

protocol SearchUseCaseInterface {
    var recentlyKeyworkdList: ReplaySubject<[String]> { get }
//    func recentlyKeyworkdList() -> Observable<[String]>
    func save(keyworkd: String)
}
