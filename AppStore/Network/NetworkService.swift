//
//  NetworkService.swift
//  AppStore
//
//  Created by jinyoung on 2023/03/19.
//

import Foundation
import RxSwift

enum ResponseResult {
    case success(Data?)
    case failure(Error)
}

enum NetworkError: Error {
    case responseError
}

final class NetworkService: NSObject {
    
    static let shared: NetworkService = NetworkService()
    
    func requestSend(request: URLRequest) -> Observable<ResponseResult> {
        return Observable.create { observable in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observable.onError(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observable.onError(NetworkError.responseError)
                    return
                }
                let range = 200..<300
                if  range.contains(httpResponse.statusCode) {
                    observable.onNext(.success(data))
                }else{
                    observable.onError(NetworkError.responseError)
                }
            }
            task.resume()
            return Disposables.create{
                task.cancel()
            }
        }
    }
    
    func requestUploadPost(request: URLRequest, data: Data) -> Observable<ResponseResult> {
        return Observable.create { observable in
            let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                if let error = error {
                    observable.onError(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observable.onError(NetworkError.responseError)
                    return
                }
                let successRange = 200..<300
                if successRange.contains(httpResponse.statusCode){
                    observable.onNext(.success(data))
                }else{
                    observable.onError(NetworkError.responseError)
                }
            }
            
            task.resume()
            return Disposables.create{
                task.cancel()
            }
        }
    }
    
    func downloadData(request: URLRequest, _ complete: @escaping(ResponseResult) -> Void) -> URLSessionDataTask {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complete(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                complete(.failure(ImageServiceError.responseError))
                return
            }
            let successRange = 200..<300
            if successRange.contains(httpResponse.statusCode){
                complete(.success(data))
            }else{
                complete(.failure(ImageServiceError.responseError))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
