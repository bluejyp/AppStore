//
//  SearchResultViewController.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultViewController: UIViewController {
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var filteredHistoryTableView: UITableView!
    weak var parentNavigationController: UINavigationController?
    
    var viewModel = SearchResultViewModel()
    let disposeBag = DisposeBag()
    
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var searchResultList = BehaviorSubject<[RawDataProtocol]>(value: [])
    var filteredKeywordHistory: PublishSubject<[String]> = PublishSubject<[String]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: SearchResultViewModel.Input(keyword: searchKeyword))
        
        output.searchResultList.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    print("##### searchResult isHidden2222: true")
                    self?.filteredHistoryTableView.isHidden = true
                    self?.searchResultList.onNext(data)
                    break
                case .failure(let error):
                    print("error: \(error)")
                    if error == .EmptyKeywordError {
                        self?.searchResultList.onNext([])
                    }
                    break
                }
            })
            .disposed(by: disposeBag)
        
        filteredKeywordHistory
            .subscribe { [weak self] history in
                print("##### searchResult isHidden: \(history.count == 0)")
                self?.searchResultList.onNext([])
                self?.filteredHistoryTableView.isHidden = history.count == 0
        }
        .disposed(by: disposeBag)
        
        filteredKeywordHistory
            .bind(to: filteredHistoryTableView.rx.items(cellIdentifier: "FilteredHistoryCell")) { (index, element, cell) in
                guard let filteredHistoryCell = cell as? FilteredHistoryCell else {
                    return
                }
                
                filteredHistoryCell.keywordLabel.text = element
            }
            .disposed(by: disposeBag)
        
        
        searchResultList.bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultCell")) { (index, element, cell) in
            if let searchResultCell = cell as? SearchResultCell,
               let info = element as? AppInfo {
                print("item:: \(info)")
                searchResultCell.viewModel = SearchResultCellViewModel(info: info)
            }
        }
        .disposed(by: disposeBag)
        
        // 최근 검색어 선택 시
        searchResultTableView.rx.modelSelected(RawDataProtocol.self)
            .subscribe { [weak self] data in
                if let info = data.element as? AppInfo {
                    self?.presentDetailViewController(info: info)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func presentDetailViewController(info: AppInfo) {
        let detailViewController = DetailViewController.storyboardInstantiate()
        detailViewController.viewModel = DetailViewModel(info: info)
        
        parentNavigationController?.pushViewController(detailViewController, animated: true)
    }
}
 
