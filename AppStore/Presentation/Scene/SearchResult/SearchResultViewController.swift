//
//  SearchResultViewController.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

enum ViewType {
    case keywordHistory
    case searchResult
    case emptyResult
    case error
}

final class SearchResultViewController: UIViewController {
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var filteredHistoryTableView: UITableView!
    @IBOutlet weak var infoCoverView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    weak var parentNavigationController: UINavigationController?
    
    var viewModel = SearchResultViewModel(searchResultUseCase: SearchResultUseCase())
    let disposeBag = DisposeBag()
    
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var searchResultList = BehaviorSubject<[RawDataProtocol]>(value: [])
    var filteredKeywordHistory: PublishSubject<[String]> = PublishSubject<[String]>()
    var viewType: ViewType = .keywordHistory{
        didSet {
            switch viewType {
            case .keywordHistory:
                filteredHistoryTableView.isHidden = false
                searchResultTableView.isHidden = true
                infoCoverView.isHidden = true
            case .searchResult:
                filteredHistoryTableView.isHidden = true
                searchResultTableView.isHidden = false
                infoCoverView.isHidden = true
            case .emptyResult:
                filteredHistoryTableView.isHidden = true
                searchResultTableView.isHidden = true
                infoCoverView.isHidden = false
                infoLabel.text = "검색 결과가 없습니다"
            case .error:
                filteredHistoryTableView.isHidden = true
                searchResultTableView.isHidden = true
                infoCoverView.isHidden = false
                infoLabel.text = "에러가 발생했습니다"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: SearchResultViewModel.Input(keyword: searchKeyword))
        
        output.searchResultList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    if data.count == 0 {
                        self?.viewType = .emptyResult
                    } else {
                        self?.viewType = .searchResult
                    }
                    
                    self?.searchResultList.onNext(data)
                    break
                case .failure(let error):
                    if error == .EmptyKeywordError {
                        self?.searchResultList.onNext([])
                    }
                    break
                }
            })
            .disposed(by: disposeBag)
        
        filteredKeywordHistory
            .subscribe { [weak self] history in
                if history.count == 0 {
                    self?.searchResultList.onNext([])
                } else {
                    self?.viewType = .keywordHistory
                }
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
        
        searchResultList
            .bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultCell")) { (index, element, cell) in
            if let searchResultCell = cell as? SearchResultCell,
               let info = element as? AppInfo {
                searchResultCell.viewModel = SearchResultCellViewModel(info: info)
            }
        }
        .disposed(by: disposeBag) 
        
        searchResultTableView.rx.modelSelected(RawDataProtocol.self)
            .subscribe { [weak self] data in
                if let info = data.element as? AppInfo {
                    self?.presentDetailViewController(info: info)
                }
            }
            .disposed(by: disposeBag)
        
        filteredHistoryTableView.rx.modelSelected(String.self)
            .subscribe { [weak self] keyword in
                self?.viewType = .searchResult
                self?.searchKeyword.onNext(keyword)
            }
            .disposed(by: disposeBag)
    }
    
    private func presentDetailViewController(info: AppInfo) {
        let detailViewController = DetailViewController.storyboardInstantiate()
        detailViewController.viewModel = DetailViewModel(info: info)
        
        parentNavigationController?.pushViewController(detailViewController, animated: true)
    }
}
 
