//
//  SceneCoordinatorType.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
