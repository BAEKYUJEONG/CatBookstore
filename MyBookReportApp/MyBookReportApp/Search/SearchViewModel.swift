//
//  SearchViewModel.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2022/08/02.
//

import Foundation
import SwiftyJSON

final class SearchViewModel {
    
    private let bookAPIService = BookAPIService()
    
    func getBook(_ text: String, _ startPage: Int, _ completion: @escaping (Result<(Int, UserBook), Error>) -> Void) {
        var totalCount: Int = 0
        var task: UserBook = UserBook()
        
        bookAPIService.getBook(text, startPage) { result in
            switch result {
            case .success(let json):
                totalCount = json["totalResults"].intValue
                
                for item in json["item"].arrayValue {
                    let bookTitle = item["title"].stringValue
                    let author = item["author"].stringValue
                    let publisher = item["publisher"].stringValue
                    let image = item["coverLargeUrl"].stringValue
                    
                    let pubDate = item["pubDate"].stringValue
                    let description = item["description"].stringValue
                    
                    let customerReviewRank = item["customerReviewRank"].floatValue
                    let reviewCount = item["reviewCount"].intValue
                    let priceStandard = item["priceStandard"].intValue
                    let link = item["link"].stringValue
                    
                    let isbn = item["isbn"].stringValue
                    
                    task = UserBook(bookTitle: bookTitle,
                                    author: author,
                                    publisher: publisher,
                                    image: image,
                                    pubDate: pubDate,
                                    descriptionBook: description,
                                    customerReviewRank: customerReviewRank,
                                    reviewCount: reviewCount,
                                    priceStandard: priceStandard,
                                    link: link,
                                    favorite: false,
                                    now: false,
                                    isbn: isbn)
                }
                completion(.success((totalCount, task)))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error.localizedDescription as! Error))
            }
        }
    }
}
