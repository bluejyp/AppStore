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
    
    var viewModel = SearchResultViewModel()
    let disposeBag = DisposeBag()
    
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    var searchResultList = BehaviorSubject<[RawDataProtocol]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    func configureUI() {
//        searchResultTableView.rx.transform()
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: SearchResultViewModel.Input(keyword: searchKeyword))
        
        output.recentlyKeywordList.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
//                    print("data: \(data)")
                    self?.searchResultList.onNext(data)
                    break
                case .failure(let error):
                    print("error: \(error)")
                    break
                }
            })
            .disposed(by: disposeBag)
        
        searchResultList.bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultCell")) { (index, element, cell) in
            print("table bind... \(index)")
            if let searchResultCell = cell as? SearchResultCell,
               let info = element as? AppInfo {
                print("title: \(info.trackName)")
                searchResultCell.itemInfo = info
            }
        }.disposed(by: disposeBag)
    }
}
 
