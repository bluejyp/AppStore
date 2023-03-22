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
    var searchRepository: SearchRepositoryInterface { get set }
    var keywordHistory: BehaviorRelay<[String]> { get }
    
    func save(keyworkd: String)
}
