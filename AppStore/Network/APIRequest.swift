//
//  APIRequest.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation

public enum RequestType: String {
    case get
    case post
}
protocol APIRequest {
    var method: RequestType { get }
    var endPoint: String { get }
    var parameters: [String: String]? { get }
    var header: [String: String]? { get }
    func buildRequest(baseURL: String) -> URLRequest?
}

extension APIRequest {
    func buildRequest(baseURL: String) -> URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }

        guard var components = URLComponents(url: url.appendingPathComponent(endPoint),
                                             resolvingAgainstBaseURL: false) else {
            return nil
        }

        if let params = parameters {
            components.queryItems = params.map {
                URLQueryItem(name: String($0), value: String($1))
            }
        }
        
        guard let comUrl = components.url else { return nil }

        var request = URLRequest(url: comUrl)
        request.httpMethod = method.rawValue

        if let head = header, head.isEmpty == false {
            request.allHTTPHeaderFields = header
        }
        
        return request
    }
}
