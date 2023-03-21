//
//  ImageDownloadUseCaseInterface.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import UIKit

enum ImageServiceError: Error {
    case responseError
    case downloadDataError
}

protocol ImageDownloadUseCaseInterface {
    func getImage(_ urlString: String, complete:@escaping(UIImage?) -> Void)
}
