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
    @Persisted var favorite: Bool // 즐겨찾기
    @Persisted var now: Bool // 현재 읽고 있는 책
    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(bookTitle: String, author: String, publisher: String, image: String) {
        self.init()
        
        self.bookTitle = bookTitle
        self.author = author
        self.publisher = publisher
        self.image = image
        self.favorite = false
        self.now = false
    }
}

//UserNote 추후 제작
