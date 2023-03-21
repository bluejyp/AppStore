//
//  ViewModelBase.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import Foundation

protocol ViewModelBase {
    associatedtype Input
    associatedtype Output
        
    func transform(input: Input) -> Output
}
