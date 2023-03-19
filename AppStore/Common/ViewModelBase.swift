//
//  ViewModelBase.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation

protocol ViewModelBase {
    associatedtype Input
    associatedtype Output
        
    func transform(input: Input) -> Output
}
