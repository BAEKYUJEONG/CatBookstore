//
//  SearchDetailViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/23.
//

import UIKit
import Kingfisher

class SearchDetailViewController: UIViewController {
    
    static let identifier = "SearchDetailViewController"
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    
    var text : String  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting()
    }
    
    func setting() {
        detailImageView.image = UIImage(systemName: "star")
        detailTitle.text = text
    }
}
