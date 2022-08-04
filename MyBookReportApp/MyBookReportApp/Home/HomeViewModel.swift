//
//  HomeViewModel.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2022/08/04.
//

import Foundation

final class HomeViewModel {
    private let bookAPIService = BookAPIService()
    
    func getBestSeller(_ completion: @escaping (Result<(Int, [UserBestBook]), Error>) -> Void) {
        
    }
}
