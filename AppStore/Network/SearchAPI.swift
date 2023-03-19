//
//  SearchAPI.swift
//  AppStore
//
//  Created by 박진영 on 2023/03/19.
//

import Foundation

final class SearchAppListConfig: NetworkConfigurable {
    typealias ParamModelType = SearchInfo
    var path: String
    var query: [String : Any]? = [:]
    var paramModel: ParamModelType? = nil
    var method: HTTPMethod
    init(keyworkd: String) {
        path = "search"
        method = .get
        guard query != nil else {
            return
        }
        self.query?["term"] = keyworkd.trimmingCharacters(in: .whitespaces)
        //        query["country"] = NSLocale.current.regionCode ?? "KR"
        self.query?["country"] = "KR"//검색결과를 확인하기 좋게 하기 위해서 KR로 고정.
        self.query?["limit"] = 15
        self.query?["entity"] = "software"
    }
    
    init(query: [String : Any]) {
        path = "search"
        self.query = query
        method = .get
    }
    
    init(info: SearchInfo) {
        path = "search"
        self.paramModel = info
        method = .post
    }
}

struct SearchInfo: Codable {
    let term: String
    let country: String?
    let limit: Int?
    var entity: String = "software"
    
    init(term: String) {
        self.term =  term.trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        self.country =  NSLocale.current.regionCode ?? "KR"
        self.country = "KR"//검색결과를 확인하기 좋게 하기 위해서 KR로 고정.
        self.limit = 15
        self.entity = "software"
    }
}