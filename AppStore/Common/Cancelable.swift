//
//  Cancelable.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import Foundation

protocol Cancellable{
    func cancel()
}

extension URLSessionTask: Cancellable {
    
}
