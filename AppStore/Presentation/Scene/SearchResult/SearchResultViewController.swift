//
//  SearchResultViewController.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultViewController: UIViewController, ViewModelBindableType {
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var viewModel: SearchResultViewModel!
    let bag = DisposeBag()
    
    var searchKeyword: PublishSubject<String> = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        bindViewModel()
        
        searchKeyword.subscribe { keyword in
            print("\(keyword)")
            
        }
    }
    
    func bindViewModel() {
        let sampleKeyword = ["kakao", "naver", "google", "naver", "google", "naver", "google", "naver", "google", "naver", "google", "naver", "google", "naver", "google", "naver", "google", "naver", "google"]
        let ob: Observable<[String]> = Observable.of(sampleKeyword)
        
        ob.bind(to: searchResultTableView.rx.items(cellIdentifier: "SearchResultCell")) { (index, element, cell) in
            
        }.disposed(by: bag)
    }
}
