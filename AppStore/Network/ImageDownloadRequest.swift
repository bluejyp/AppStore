//
//  ImageDownloadRequest.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import UIKit

class ImageDownloadRequest: ImageDownloadConfigurable {
    
    var paramModel: SearchInfo?
    
    var imageURLString: String
    var method: HTTPMethod
    
    init(urlStrtig: String, method: HTTPMethod = .get) {
        self.imageURLString = urlStrtig
        self.method = method
    }
    
}

