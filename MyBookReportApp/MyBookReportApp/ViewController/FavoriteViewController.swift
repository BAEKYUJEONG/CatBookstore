//
//  FavoriteViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
