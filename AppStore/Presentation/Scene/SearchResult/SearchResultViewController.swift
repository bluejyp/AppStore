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
    @IBOutlet weak var searchKeywordTableView: UITableView!
    weak var parentNavigationController: UINavigationController?
    
    var viewModel = SearchResultViewModel()
    let disposeBag = DisposeBag()
    
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var searchResultList = BehaviorSubject<[RawDataProtocol]>(value: [])
    var filteredKeywordHistory: PublishSubject<[String]> = PublishSubject<[String]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        /*
            - hidden 조건
                searchAPI request시 hidden
                cancel눌렀을 때 알빠노
                필터 결과물이 없으면 hidden
         
            - show 조건
                searchBar 텍스트가 변경되면 show     X
                
         
         */
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: SearchResultViewModel.Input(keyword: searchKeyword))
        
        output.searchResultList.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    self?.searchResultList.onNext(data)
                    break
                case .failure(let error):
                    print("error: \(error)")
                    break
                }
            })
            .disposed(by: disposeBag)
        
        filteredKeywordHistory
            .subscribe { history in
                self.searchKeywordTableView.isHidden = history.count == 0
                print("searchResult:: \(history)")
        }
        .disposed(by: disposeBag)
        
        filteredKeywordHistory
            .bind(to: searchKeywordTableView.rx.items(cellIdentifier: "filterdHistoryCell")) { (index, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        searchResultList.bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultCell")) { (index, element, cell) in
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
    }
    
    private func presentDetailViewController(info: AppInfo) {
        let detailViewController = DetailViewController.storyboardInstantiate()
        detailViewController.viewModel = DetailViewModel(info: info)
        
        parentNavigationController?.pushViewController(detailViewController, animated: true)
    }
}
 
