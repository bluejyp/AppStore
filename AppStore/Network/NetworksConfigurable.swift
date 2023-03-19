//
//  NetworksConfigurable.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation
import Network

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case connect = "CONNECT"
    case patch = "PATCH"
}

enum NetworkProtocol: String {
    case http = "http://"
    case https = "https://"
}

protocol NetworkConfigurable {
    associatedtype ParamModelType: Encodable
    var scheme: NetworkProtocol { get }
    var host: String { get } // SCheme + Host
    var path: String { get }
    var header: [String : String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    
    var query: [String : Any]? { get }
    var method: HTTPMethod { get }
    
    var paramModel: ParamModelType? { get set }
    
}

extension NetworkConfigurable {
    
    var scheme: NetworkProtocol {
        return .https
    }
    
    var host: String{
        return scheme.rawValue + "itunes.apple.com"
    }
    
    var header: [String : String] {
        var header = ["Content-Type": "application/json"]
        let bundleVersion = ""
        header["app-version"] = bundleVersion
        header["app-timezone-id"] = TimeZone.current.identifier
        return header
    }
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    
    private var serviceURL: String {
        return host + "/" + path
    }
    
    private var queryItems: [URLQueryItem]? {
        guard let query = query, query.count > 0 else {
            return nil
        }
        return query.map { URLQueryItem(name: $0.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" , value: "\($1)") }
    }
    
    private var paramData_wwwform: Data? {
        guard let query = query, query.count > 0 else{
            return nil
        }
        return query.map {
            let key = "\($0)".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) ?? ""
            let value = "\($1)"//.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return key + "=" + value
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    
    private var paramData: Data? {
        do {
            if let model = paramModel {
                let paramData = try JSONEncoder().encode(model)
                return paramData
            }else{
                guard let query = query else{
                    return nil
                }
                let paramData = try JSONSerialization.data(withJSONObject: query, options:[])
                return paramData
            }
        }
        catch {
            print("error")
        }
        return nil
    }
    
    func request() -> URLRequest {
        print("serviceURL - \(serviceURL)")
        switch method {
        case .get:
            return requestGet()
        default:
            return requestBody()
        }
    }
    
    private func requestGet() -> URLRequest {
        var urlComponets = URLComponents(string: serviceURL)
        if let queryItems = queryItems {
            urlComponets?.queryItems = queryItems
        }
        guard let components = urlComponets , let requestURL = components.url else{
            fatalError("rquest send Fail")
        }
        print("compnents - \(components)")
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        urlRequest.cachePolicy = cachePolicy
        //https://itunes.apple.com/search?entity=software&term=%EC%B9%B4%EC%B9%B4%EC%98%A4&limit=15
        //https://itunes.apple.com/search?term=%25EC%25B9%25B4%25EC%25B9%25B4%25EC%2598%25A4&limit=15&entity=software
        return urlRequest
    }
    
    private func requestBody() -> URLRequest {
        let urlComponets = URLComponents(string: serviceURL)
   
        guard let requestURL = urlComponets?.url else{
            fatalError("rquest send Fail")
        }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.allHTTPHeaderFields = header
        
        if let data = paramData_wwwform {
            urlRequest.httpBody = data
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(String(data.count), forHTTPHeaderField: "Content-Length")
        }
        //        if let data = paramData {
        //// Post Man으로 확인해본 결과 itune 는 application/josn 타입으로 응답이 안됨.
        //            urlRequest.httpBody = data
        //            urlRequest.addValue(String(data.count), forHTTPHeaderField: "Content-Length")
        //            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        //        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = cachePolicy
        return urlRequest
    }
}


protocol ImageDownloadConfigurable: NetworkConfigurable {
    var imageURLString: String { get set }
}

extension ImageDownloadConfigurable {
    
    var query: [String : Any]? {
        return [:]
    }
    var path: String {
        return ""
    }
    
    func downloadRequest() -> URLRequest {
        print("downloadURL - \(imageURLString)")
        let urlComponets = URLComponents(string: imageURLString)
        guard let requestURL = urlComponets?.url else{
            fatalError("rquest send Fail")
        }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        urlRequest.cachePolicy = cachePolicy
        
        return urlRequest
    }
}

