//
//  RealmModel.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/23.
//

import Foundation
import RealmSwift

// UserBook : 테이블 이름
// @Persisted : 컬럼
class UserBook: Object {
    @Persisted var bookTitle: String // 책 제목
    @Persisted var author: String // 작가
    @Persisted var publisher: String // 출판사
    @Persisted var image: String // 이미지 링크
    
    @Persisted var pubDate: String // 출간일
    @Persisted var descriptionBook: String // 책 소개
    
    @Persisted var customerReviewRank: Float // 리뷰 평점
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    
    // 중요!
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, priceStandard: Int, link: String, favorite: Bool, now: Bool, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.priceStandard = priceStandard
        self.link = link
        
        self.favorite = favorite
        self.now = now
        
        self.isbn = isbn
    }
}

// UserFavoriteBook : 테이블 이름
// @Persisted : 컬럼
class UserFavoriteBook: Object {
    @Persisted var bookTitle: String // 책 제목
    @Persisted var author: String // 작가
    @Persisted var publisher: String // 출판사
    @Persisted var image: String // 이미지 링크
    
    @Persisted var pubDate: String // 출간일
    @Persisted var descriptionBook: String // 책 소개
    
    @Persisted var customerReviewRank: Float // 리뷰 평점
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    
    // 중요!
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, priceStandard: Int, link: String, favorite: Bool, now: Bool, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.priceStandard = priceStandard
        self.link = link
        
        self.favorite = favorite
        self.now = now
        
        self.isbn = isbn
    }
}


//UserNote 추후 제작
