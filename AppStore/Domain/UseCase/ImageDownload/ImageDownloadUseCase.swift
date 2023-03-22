//
//  ImageDownloadUseCase.swift
//  AppStore
//
//  Created by Jinyoung on 2023/03/20.
//

import UIKit

final class ImageDownloadUseCase: ImageDownloadUseCaseInterface {
    static let shared = ImageDownloadUseCase()
    
    private var cache = NSCache<NSString,UIImage>()
    private let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    private let fileManager = FileManager.default

    private var cancelList: [String : Cancellable] = [:]
    
    private init() {

    }

    private func loadImage(_ key: String) -> UIImage? {
        guard let image = cache.object(forKey: key as NSString) else {
            return getImageFile(key)
        }
        return image
    }
    
    private func addImage(_ key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
        addImageFile(key, image)
    }
    
    private func removeImage(_ key: String) {
        cache.removeObject(forKey: key as NSString)
        removeImageFile(key)
    }
    
    private func removeAllImage() {
        cache.removeAllObjects()
        removeAllImageFile()
    }
    
    private func getImageFile(_ key: String) -> UIImage? {
        if let data = try? Data(contentsOf: filePath(key)) {
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
    private func addImageFile(_ key: String, _ image: UIImage) {
        do {
            guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
                return
            }
            
            if fileManager.fileExists(atPath: cachePath.path) == false {
                try fileManager.createDirectory(at: cachePath, withIntermediateDirectories: true)
            }
            
            try data.write(to: filePath(key),options: .atomic)
        } catch {
            // nothing
        }
    }

    private func removeImageFile(_ key: String) {
        let filePath = filePath(key)
        if fileManager.fileExists(atPath: filePath.path) {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
    private func removeAllImageFile() {
        try? fileManager.removeItem(at: cachePath)
    }
    
    private func filePath(_ key: String) -> URL{
        return cachePath.appendingPathComponent(makeFileName(key))
    }
    
    private func makeFileName(_ key: String) -> String {
        return NSString(string: key).replacingOccurrences(of: "/", with: "-")
    }
}

extension ImageDownloadUseCase {
    func getImage(_ urlString: String, complete: @escaping (UIImage?) -> Void) {
        if let image = loadImage(urlString) {
            complete(image)
            return
        }
        let request = ImageDownloadRequest(urlStrtig: urlString).downloadRequest()
        let task = NetworkService.shared.downloadData(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                if let downloadData = data , let image = UIImage(data: downloadData) {
                    complete(image)
                    self?.addImage(urlString, image: image)
                    self?.cancelTask(key: urlString)
                }
            case .failure(_):
                self?.cancelTask(key: urlString)
                complete(nil)
            }
        }
        addCancellable(key: urlString, task: task)
        
    }
    
    func addCancellable(key: String, task: Cancellable){
        DispatchQueue.main.async {
            if let task = self.cancelList[key] {
                task.cancel()
            }
            self.cancelList[key] = task
        }
    }
    
    func cancelTask(key: String) {
        DispatchQueue.main.async {
            if let task = self.cancelList[key] {
                task.cancel()
                self.cancelList.removeValue(forKey: key)
            }
        }
    }
}
