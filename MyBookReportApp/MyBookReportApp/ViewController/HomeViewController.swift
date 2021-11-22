//
//  HomeViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeSearchBar.delegate = self
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    // 커서가 깜빡이기 시작할 때 -> 클릭했을 때 처럼 보임!!
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        
        // 1. storyboard
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        // 2. viewcontroller
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        // 3. Push
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
