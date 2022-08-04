//
//  EndPoint.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2022/08/01.
//

import Foundation

enum EndPoint {
    case getBook(String, Int)
    case getBestSeller
}

extension EndPoint {
    static let key = "195C74CC11F90BF250E1A5B4F89FA5FC997F3C9AB7F2F3DA1272D342B5B5DB8D"
    
    var url: URL {
        switch self {
        case .getBook(let text, let startPage):
            return .makeEndPoint("search.api?key=\(EndPoint.key)&query=\(text)&output=json&start=\(startPage)&maxResults=10&sort=salesPoint")
        case .getBestSeller:
            return .makeEndPoint("bestSeller.api?key=\(EndPoint.key)&categoryId=100&output=json")
        }
    }
}

extension URL {
    static let baseURL = "http://book.interpark.com/api/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}
