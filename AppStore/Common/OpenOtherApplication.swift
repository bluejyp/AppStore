//
//  OpenOtherApplication.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import Foundation

protocol OpenOtherApplication {
    func openApplication(bundleID: String) -> Bool
}

extension OpenOtherApplication {
    /// Application설치 유무를 판단해서 Open까지.
    /// - Parameter bundleID: BundleID
    /// - Returns: Open 성공여부 전달.
    func openApplication(bundleID: String) -> Bool{
        guard let obj = objc_getClass("LSApplicationWorkspace") as? NSObject else {
            return false
        }
        
        let workspace = obj.perform(Selector(("defaultWorkspace")))?.takeUnretainedValue() as? NSObject
        let open = workspace?.perform(Selector(("openApplicationWithBundleID:")), with: bundleID) != nil

        return open
    }
}
