//
//  SearchUseCaseInterface.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchUseCaseInterface {
    var keywordHistory: BehaviorRelay<[String]> { get }
    func save(keyworkd: String)
}
