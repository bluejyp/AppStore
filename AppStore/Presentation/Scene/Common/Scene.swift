//
//  Scene.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit

enum Scene {
    case search
    case searchResult
    case detail(DetailViewModel)
}

extension Scene {
    func instantiate(from storyboardName: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        switch self {
        case .search:
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? UINavigationController,
                  var searchVC = navigationController.viewControllers.first as? SearchViewController else {
                return storyboard.instantiateViewController(withIdentifier: "SearchVC")
            }
            
            return navigationController
        case .searchResult:
            guard var searchResultVC = storyboard.instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController else {
                return storyboard.instantiateViewController(withIdentifier: "SearchResultVC")
            }
            
//            searchResultVC.bind(viewModel: searchResultViewModel)
            
            return searchResultVC
        case .detail(let detailViewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else {
                return storyboard.instantiateViewController(withIdentifier: "DetailVC")
            }
            
            detailVC.bind(viewModel: detailViewModel)
            
            return detailVC
        }
    }
}
