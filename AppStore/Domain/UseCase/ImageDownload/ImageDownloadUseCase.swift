//
//  ImageDownloadUseCase.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/20.
//

import UIKit

enum CachePolicy {
    case memory_only
    case disk_cache
}
class ImageDownloadUseCase: ImageDownloadUseCaseInterface {
    static let shared = ImageDownloadUseCase()
    
    private var cache = NSCache<NSString,UIImage>()
    private let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    private let fileManager = FileManager.default

    private var cancelList: [String : Cancellable] = [:]
    
    private init() {

    }
    /// - Parameter key: Image URL String
    /// - Returns: Cached Image (Null Able)
    private func loadImage(_ key: String) -> UIImage? {
        guard let image = cache.object(forKey: key as NSString) else {
            return getImage_File(key)
        }
        return image
    }
    
    ///   정책에 따라 Memory, Disk 순으로 이미지를 Cache합니다.
    /// - Parameters:
    ///   - key: Image URL String
    ///   - image:  wnloaded Image
    private func addImage(_ key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
        addImage_File(key, image)
    }
    
    ///  삭제는 둘다 진행합니다.. 정책이 변경될떄 남아 있지 않도록 하기 위함.
    /// - Parameter key: Image URL String
    private func removeImage(_ key: String) {
        cache.removeObject(forKey: key as NSString)
        removeImage_File(key)
    }
    
    /// 모두 삭제,  삭제는 둘다 진행합니다. 정책이 변경될떄 남아 있지 않도록 하기 위함.
    private func removeAllImage() {
        cache.removeAllObjects()
        removeAllImage_File()
    }
    
    // MARK: - FileCache
    
    ///   File Path 에 이미지를 저장된 이미지를 반환합니다.
    /// - Parameter key: image URL String
    /// - Returns: Cached Image (Null Able)
    private func getImage_File(_ key: String) -> UIImage? {
        if let data =  try? Data(contentsOf: filePath(key)) {
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
    ///  이미지를 File Path에 저장합니다.
    /// - Parameters:
    ///   - key: Image URL String
    ///   - image: Downloaded Image
    private func addImage_File(_ key: String, _ image: UIImage) {
        do{
            guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
                return
            }
            
            if fileManager.fileExists(atPath: cachePath.path) == false {
                try fileManager.createDirectory(at: cachePath, withIntermediateDirectories: true)
            }
            
            try data.write(to: filePath(key),options: .atomic)
        } catch {
            
        }
    }
    
    /// File Path 에 이미지를 삭제 합니다.
    /// - Parameter key: Image URL String
    private func removeImage_File(_ key: String) {
        let filePath = filePath(key)
        if fileManager.fileExists(atPath: filePath.path) {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
    /// 이미지 저장 경로 폴더를 전체 삭제 합니다.
    private func removeAllImage_File() {
        try? fileManager.removeItem(at: cachePath)
    }
    
    ///  File Path를 생성합니다.
    /// - Parameter key: Image URL String
    /// - Returns: FilePath URL
    private func filePath(_ key: String) -> URL{
        return cachePath.appendingPathComponent(makeFileName(key))
    }
    
    ///  Image URL 에서 File 이름은 같은 케이스들이 있기 때문에 URL을 변경해서 파일 이름을 만듭니다.
    ///  폴더 경로로 인식되는 '/' 를 '-'로 치환해서 사용합니다.
    /// - Parameter key: Image URL String
    /// - Returns: 변경된 FileName String
    private func makeFileName(_ key: String) -> String {
        return NSString(string: key).replacingOccurrences(of: "/", with: "-")
    }
}

extension ImageDownloadUseCase {
    func getImage(_ urlString: String, complete: @escaping (UIImage?) -> Void){
        if let image = loadImage(urlString) {
            complete(image)
            return
        }
        let request = ImageDownloadRequest(urlStrtig: urlString).downloadRequest()
        let task = NetworkService.shared.downloadData(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                if let downloadData = data , let image = UIImage(data: downloadData){
                    complete(image)
                    self?.addImage(urlString, image: image)
                    self?.cancelTask(key: urlString)
                }
            case .failure(_):
                complete(nil)
                self?.cancelTask(key: urlString)
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
