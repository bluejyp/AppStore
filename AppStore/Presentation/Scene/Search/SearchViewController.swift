//
//  SearchViewController.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/18.
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
    let disposeBag = DisposeBag()
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var recentlyKeywordList = PublishSubject<[String]>()
    var currentKeyword: PublishSubject<String> = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
        bindSearchView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI() {
        self.navigationItem.title = "검색"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: SearchViewModel.Input(keyword: searchKeyword, currentKeyword: currentKeyword))

        output.recentlyKeywordList
            .bind(to: recentlyKeywordTableView.rx.items(cellIdentifier: "KeywordHistoryCell")) { (index, element, cell) in
                if let keywordHistoryCell = cell as? KeywordHistoryCell {
                    keywordHistoryCell.keywordLabel.text = element
                }
            }
            .disposed(by: disposeBag)
        
        output.filteredKeyWordHistory
            .bind(to: searchResultController.filteredKeywordHistory)
            .disposed(by: disposeBag)
            
        recentlyKeywordTableView.rx.modelSelected(String.self)
            .subscribe { [weak self] keyword in
                self?.executeSearching(with: keyword)
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSearchView() {
        searchController.searchBar.rx.searchButtonClicked
            .compactMap { [weak self] in
                return self?.searchController.searchBar.text
            }.bind(to: searchResultController.searchKeyword)
            .disposed(by: disposeBag)
         
        searchController.searchBar.rx.searchButtonClicked
            .bind { [weak self] in
                let string = self?.searchController.searchBar.text ?? ""
                self?.searchResultController.searchResultList.onNext([])
                self?.searchKeyword.onNext(string)
            }
            .disposed(by: disposeBag)

        searchController.searchBar.rx.text
            .subscribe { [weak self] keyword in
            self?.currentKeyword.onNext(keyword ?? "")
        }
        .disposed(by: disposeBag)

        searchController.searchBar.rx.cancelButtonClicked
            .compactMap{""}
            .bind(to: searchResultController.searchKeyword)
            .disposed(by: disposeBag)
    }

    private func executeSearching(with keyword: String) {
        searchController.searchBar.text = keyword
        searchKeyword.onNext(keyword)
        searchResultController.searchKeyword.onNext(keyword)
        searchController.searchBar.becomeFirstResponder()
    }
}
