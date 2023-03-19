//
//  ViewModelBindableType.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype viewModelType
    
    var viewModel: viewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.viewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
