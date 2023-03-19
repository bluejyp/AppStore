//
//  SceneCoordinator.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation
import RxSwift
import RxCocoa

//class SceneCoordinator: SceneCoordinatorType {
//    private let bag = DisposeBag()
//
//    private var window: UIWindow
//    private var currentVC: UIViewController
//
//    required init(window: UIWindow) {
//        self.window = window
//        currentVC = window.rootViewController!
//    }
//
//    @discardableResult
//    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> RxSwift.Completable {
//        let subject = PublishSubject<Never>()
//        let target = scene.instantiate()
//
//        switch style {
//        case .root:
//            currentVC = target
//            window.rootViewController = target
//
//            subject.onCompleted()
//        case .push:
//        break
//        }
//    }
//
//    @discardableResult
//    func close(animated: Bool) -> RxSwift.Completable {
//
//    }
//}
