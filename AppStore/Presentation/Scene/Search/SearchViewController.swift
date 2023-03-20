//
//  SearchViewController.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/18.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    @IBOutlet weak var recentlyKeywordTableView: UITableView!
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.autocapitalizationType = .none
        return searchController
    }()
    
    lazy var searchResultController: SearchResultViewController = {
        let resultViewController = SearchResultViewController.storyboardInstantiate()
        resultViewController.parentNavigationController = self.navigationController
        return resultViewController
    }()
    
    var viewModel = SearchViewModel()
    let bag = DisposeBag()
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var recentlyKeywordList = PublishSubject<[String]>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
        bindingSearchView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func bindViewModel() {
        let output = viewModel.transform(input: SearchViewModel.Input(keyword: searchKeyword))
        
        output.recentlyKeywordList
            .bind(to: recentlyKeywordTableView.rx.items(cellIdentifier: "RecentlyKeywordCell")) { (index, element, cell) in
                cell.textLabel?.text = element
            }.disposed(by: bag)
    }
}

extension SearchViewController {
    private func configureUI() {
        
        self.navigationItem.title = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    fileprivate func bindingSearchView() {
        //SearchButton to serachresultcontroller.searchKeyword
        searchController.searchBar.rx.searchButtonClicked
            .compactMap { [weak self] in
                return self?.searchController.searchBar.text
            }.bind(to: searchResultController.searchKeyword)
            .disposed(by: self.bag)
        
//
        searchController.searchBar.rx.searchButtonClicked
            .bind { [weak self] in
//                self?.viewModel.transform(input: SearchViewModel.Input(keyword: self!.searchKeyword))
                print("searchButtonClicked bind2")
            }
            .disposed(by: self.bag)

        //cancleButton to remove SearchResult
        searchController.searchBar.rx.cancelButtonClicked
            .compactMap{""}
            .bind(to: searchResultController.searchKeyword)
            .disposed(by: bag)
            
    //TODO: - SearchBar Delete Button Action 연결하기
    }

}
