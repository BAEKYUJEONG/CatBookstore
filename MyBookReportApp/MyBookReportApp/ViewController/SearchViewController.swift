//
//  SearchViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController: UIViewController {

    static let identifier = "SearchViewController"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        showKeyboard()
    }
    
    func showKeyboard() {
        searchBar.becomeFirstResponder()
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
        
        // shadow가 있으려면 layer.borderWidth 값이 필요 : 테두리 두께
        cell.view.layer.borderWidth = 0
        // 테두리 밖으로 contents가 있을 때, 마스킹(true)하여 표출안되게 할것인지 마스킹을 off(false)하여 보일것인지 설정
        cell.view.layer.masksToBounds = false
        // shadow 색상
        cell.view.layer.shadowColor = UIColor.gray.cgColor
        // 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        cell.view.layer.shadowOffset = CGSize(width: 3, height: 3)
        // shadow의 투명도 (0 ~ 1)
        cell.view.layer.shadowOpacity = 0.3
        
        cell.view.layer.cornerRadius = 10.0
        cell.view.layer.shadowRadius = 10.0
        
        cell.bookImageView.backgroundColor = .systemYellow
        cell.bookImageView.layer.borderWidth = 3
        cell.bookImageView.layer.borderColor = CGColor.init(red: 256, green: 256, blue: 256, alpha: 1)
        cell.bookImageView.layer.cornerRadius = 10.0
        cell.bookImageView.layer.shadowRadius = 10.0
        
        cell.bookImageView.layer.masksToBounds = false
        cell.bookImageView.layer.shadowColor = UIColor.gray.cgColor
        cell.bookImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.bookImageView.layer.shadowOpacity = 0.3
        
        cell.bookTitle.text = "안녕 곰돌이 푸"
        cell.bookWriter.text = "곰돌이"
        cell.bookPublisher.text = "비룡소"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
