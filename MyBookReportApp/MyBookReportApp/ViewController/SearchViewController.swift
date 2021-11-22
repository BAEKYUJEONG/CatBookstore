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

class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        showKeyboard()
    }
    
    func showKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    // 네이버 책 네트워크 통신
    func fetchBookData(query: String) {
        if let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/book.json?query=\(text)"
            
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
                        let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let author = item["author"].stringValue
                        let publisher = item["publisher"].stringValue
                        
                        let description = item["description"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
