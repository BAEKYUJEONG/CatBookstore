//
//  Model.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/23.
//

import Foundation

var bookQuotes: [String] = [
    "그 하룻밤, 그 책 한권,\n그 한줄로 혁명이 가능해질지도 모른다.\n- 니체",
    "닫혀있기만 한 책은 블록일 뿐이다.\n- 토마스 풀러",
    "가장 싼 값으로\n가장 오랫동안 즐거움을 누릴 수 있는 것,\n바로 책이다.\n- 미셸 드 몽테뉴",
    "보기 드문 지식인을 만났을 때는\n그가 무슨 책을 읽는가를 물어보아야한다.\n- 랄프 왈도 에머슨",
    "낡은 외투를 그냥 입고\n새 책을 사라.\n- 오스틴 펠프스",
    "책 없는 방은\n영혼 없는 육체와도 같다.\n- 키케로",
    "나는 삶을 변화시키는 아이디어를\n항상 책에서 얻었다.\n- 벨 훅스",
    "읽다 죽어도\n멋져 보일 책을 항상 읽으라.\n- P. J. 오루크",
    "한 권의 책을 읽음으로써\n자신의 삶에서 새 시대를 본 사람이 너무나 많다.\n- 헨리 데이비드 소로우"
]

var bookQuotesImages: [String] = [
    "https://i.pinimg.com/564x/ba/e8/ef/bae8ef910aea2cb5b85c7fa10308b3f3.jpg",
    "https://i.pinimg.com/564x/cc/06/53/cc06534e19975b6e7ddaf3f49ab3c3d7.jpg",
    "https://i.pinimg.com/564x/c0/a6/89/c0a68958cec3b887298c4fbd0a420ff4.jpg",
    "https://i.pinimg.com/564x/c3/cb/28/c3cb286cbafe149ed0762596a8f7cc13.jpg",
    "https://i.pinimg.com/564x/71/e8/92/71e892c8ec61be4594886d101de1d945.jpg"
]

struct BookModel {
    var titleData: String
    var authorData: String
    var publisherData: String
    var imageData: String
}
