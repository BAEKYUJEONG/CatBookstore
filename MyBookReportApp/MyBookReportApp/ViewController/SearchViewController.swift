//
//  SearchViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import RealmSwift

class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserBook>!
    
    var bookData: [BookModel] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // UITableViewDataSourePrefetching 프로토콜
        searchTableView.prefetchDataSource = self
        
        searchBar.delegate = self
        //searchBar.showsCancelButton = true
        
        showKeyboard()
        
        title = "책 검색"
        tasks = localRealm.objects(UserBook.self)
        print("테스크", tasks)
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
    
    func showKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    // 네이버 책 네트워크 통신
    func fetchBookData(query: String) {
        if let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/book.json?query=\(text)&display=10&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id":"5EILmJiFoYNFhUzC8tul",
                "X-Naver-Client-Secret":"28tK7AHt65"
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    self.totalCount = json["total"].intValue
                    
                    for item in json["items"].arrayValue {
                        let bookTitle = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        
                        let image = item["image"].stringValue
                        //let link = item["link"].stringValue
                        let author = item["author"].stringValue
                        let publisher = item["publisher"].stringValue
                        
                        //let description = item["description"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        
                        let task = UserBook(bookTitle: bookTitle, author: author, publisher: publisher, image: image)
                        //let data = BookModel(titleData: bookTitle, authorData: author, publisherData: publisher, imageData: image)
                        
                        try! self.localRealm.write {
                            self.localRealm.add(task)
                        }
                        //self.bookData.append(data)
                        
                    }
                    
                    DispatchQueue.main.async {
                        // 중요!
                        self.searchTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


extension SearchViewController: UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if tasks.count - 1 == indexPath.row && tasks.count < totalCount {
                startPage += 10
                fetchBookData(query: searchBar.text!)
                print("prefetch:\(indexPath)")
            }
        }
    }
    
    // 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    // 검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            try! localRealm.write {
                localRealm.deleteAll()
            }
            //bookData.removeAll()
            startPage = 1
            fetchBookData(query: text)
        }
    }
    
    /*
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        try! localRealm.write {
            localRealm.deleteAll()
        }
        //bookData.removeAll()
        searchTableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에서 커서가 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    */
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        //bookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        //bookData[indexPath.row]
        
        if let url = URL(string: row.image) {
            cell.bookImageView.kf.setImage(with: url)
        } else {
            cell.bookImageView.image = UIImage(systemName: "star")
        }
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
