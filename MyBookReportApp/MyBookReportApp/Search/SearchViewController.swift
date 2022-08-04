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
    private var viewModel = SearchViewModel()
    
    let localRealm = try! Realm()
    var tasks: Results<UserBook>!
    
    @IBOutlet weak var systemLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var startPage = 1
    var totalCount = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "책 검색"
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchBar.delegate = self
        
        showKeyboard()
        bind(viewModel)
        
        tasks = localRealm.objects(UserBook.self)
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
    
    private func bind(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    private func showKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    private func fetchBookData(query: String) {
        if let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            viewModel.getBook(text, startPage) { result in
                switch result {
                case .success(let bookData):
                    let totalCount = bookData.0
                    let tasks = bookData.1
                    
                    self.totalCount = totalCount
                    
                    try! self.localRealm.write {
                        self.localRealm.add(tasks)
                    }
                    
                    DispatchQueue.main.async {
                        self.searchTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.systemLabel.isHidden = false
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
            }
        }
    }
    
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
                localRealm.delete(localRealm.objects(UserBook.self))
            }
            startPage = 1
            fetchBookData(query: text)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        if let url = URL(string: row.image) {
            cell.bookImageView.kf.setImage(with: url)
        } else {
            cell.bookImageView.image = UIImage(systemName: "nosign")
        }
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "SearchDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
        
        let row = tasks[indexPath.row]
        vc.titleText = row.bookTitle
        vc.authorText = row.author
        vc.publisherText = row.publisher
        vc.imageText = row.image
        
        vc.pubDateText = row.pubDate
        vc.descriptionText = row.descriptionBook
        
        vc.customerReviewRank = row.customerReviewRank
        vc.reviewCount = row.reviewCount
        vc.priceStandard = row.priceStandard
        vc.linkText = row.link
        
        vc.nowBool = row.now
        
        vc.isbnText = row.isbn
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
