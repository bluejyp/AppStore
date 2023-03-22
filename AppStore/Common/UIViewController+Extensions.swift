//
//  UIViewController+Extensions.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/19.
//

import UIKit

extension UIViewController {
    static func storyboardInstantiate(name storyboard: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".").last ?? fullName
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self {
            return viewController
        }
        return Self()
    }
}
