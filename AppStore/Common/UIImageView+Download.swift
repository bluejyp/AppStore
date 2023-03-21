//
//  UIImageView+Download.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import UIKit

extension UIImageView {
    
    private struct CustomProperties {
        static var downloadURLString: String? = nil
    }
    
    var downloadURL : String? {
        get {
            return objc_getAssociatedObject(self, &CustomProperties.downloadURLString) as? String
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &CustomProperties.downloadURLString, value , .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    ///  Cache 이미지를 탐색하고 없다면 Download를 진행해서 적용하고 , 저장합니다.
    /// - Parameter urlStrig: Image URL String
    func setImage(urlStrig: String) {
        self.cancelDownload()
        self.downloadURL = urlStrig
        self.image = UIImage(named: "placeholder")
        ImageDownloadUseCase.shared.getImage(urlStrig) { image in
            DispatchQueue.main.async { [weak self] in
                if let image = image {
                    self?.image = image
                }else{
                    self?.image = UIImage(named: "placeholder")
                }
            }
        }
    }
    
    func cancelDownload(){
        guard let key = self.downloadURL else {
            return
        }
        ImageDownloadUseCase.shared.cancelTask(key: key)
        self.downloadURL = nil
    }
}
 
