//
//  Cancelable.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import Foundation

protocol Cancellable{
    func cancel()
}

extension URLSessionTask: Cancellable {
    
}
