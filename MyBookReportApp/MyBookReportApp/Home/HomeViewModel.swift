//
//  HomeViewModel.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2022/08/04.
//

import Foundation

final class HomeViewModel {
    private let bookAPIService = BookAPIService()
    
    func getBestSeller(_ completion: @escaping (Result<([UserBestBook], [String]), Error>) -> Void) {
        var tasks: [UserBestBook] = []
        var images: [String] = []
        
        bookAPIService.getBestSeller { result in
            switch result {
            case .success(let json):
                for item in json["item"].arrayValue {
                    let title = item["title"].stringValue
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
                    
                    let task = UserBestBook(bookTitle: title,
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
                    tasks.append(task)
                    images.append(image)
                }
                completion(.success((tasks, images)))
            case .failure(let error):
                completion(.failure(error.localizedDescription as! Error))
            }
        }
    }
}
