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
    @Persisted var reviewCount: Int // 리뷰 갯수
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, reviewCount: Int, priceStandard: Int, link: String, favorite: Bool, now: Bool, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.reviewCount = reviewCount
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
    @Persisted var reviewCount: Int // 리뷰 갯수
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    @Persisted var writeDate = Date() // 등록일
    
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, reviewCount: Int, priceStandard: Int, link: String, favorite: Bool, now: Bool, writeDate: Date, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.reviewCount = reviewCount
        self.priceStandard = priceStandard
        self.link = link
        
        self.favorite = favorite
        self.now = now
        self.writeDate = writeDate
        
        self.isbn = isbn
    }
}

// UserNote : 테이블 이름
// @Persisted : 컬럼
class UserNote: Object {
    @Persisted var bookTitle: String // 책 제목
    @Persisted var author: String // 작가
    @Persisted var image: String // 이미지 링크
    
    @Persisted var note: String // 노트 내용
    @Persisted var writeDate = Date() // 노트 등록일
    
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, image: String, note: String, writeDate: Date, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.image = image
        
        self.note = note
        self.writeDate = writeDate
        
        self.isbn = isbn
    }
}

// UserBestBook : 테이블 이름
// @Persisted : 컬럼
class UserBestBook: Object {
    @Persisted var bookTitle: String // 책 제목
    @Persisted var author: String // 작가
    @Persisted var publisher: String // 출판사
    @Persisted var image: String // 이미지 링크
    
    @Persisted var pubDate: String // 출간일
    @Persisted var descriptionBook: String // 책 소개
    
    @Persisted var customerReviewRank: Float // 리뷰 평점
    @Persisted var reviewCount: Int // 리뷰 갯수
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, reviewCount: Int, priceStandard: Int, link: String, favorite: Bool, now: Bool, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.reviewCount = reviewCount
        self.priceStandard = priceStandard
        self.link = link
        
        self.favorite = favorite
        self.now = now
        
        self.isbn = isbn
    }
}

// UserRecentBook : 테이블 이름
// @Persisted : 컬럼
class UserRecentBook: Object {
    @Persisted var bookTitle: String // 책 제목
    @Persisted var author: String // 작가
    @Persisted var publisher: String // 출판사
    @Persisted var image: String // 이미지 링크
    
    @Persisted var pubDate: String // 출간일
    @Persisted var descriptionBook: String // 책 소개
    
    @Persisted var customerReviewRank: Float // 리뷰 평점
    @Persisted var reviewCount: Int // 리뷰 갯수
    @Persisted var priceStandard: Int // 표준가
    @Persisted var link: String // 구매링크
    
    @Persisted var writeDate = Date() // 등록일
    
    // 중요!
    @Persisted var isbn: String // 책 주민등록번호
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String, pubDate: String, descriptionBook: String, customerReviewRank: Float, reviewCount: Int, priceStandard: Int, link: String, writeDate: Date, isbn: String) {
        
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        
        self.pubDate = pubDate
        self.descriptionBook = descriptionBook
        
        self.customerReviewRank = customerReviewRank
        self.reviewCount = reviewCount
        self.priceStandard = priceStandard
        self.link = link
        
        self.writeDate = writeDate
        
        self.isbn = isbn
    }
}
