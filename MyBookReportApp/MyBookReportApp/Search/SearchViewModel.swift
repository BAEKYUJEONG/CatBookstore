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
    
    func getBook(_ text: String, _ startPage: Int, _ completion: @escaping (Result<JSON, Error>) -> Void) {
        bookAPIService.getBook(text, startPage, completion)
    }
}
