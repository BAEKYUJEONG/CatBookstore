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
    @IBOutlet weak var detailAuthor: UILabel!
    @IBOutlet weak var detailPublisher: UILabel!
    
    @IBOutlet weak var detailPubDate: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBOutlet weak var detailCustomerReviewRank: UILabel!
    @IBOutlet weak var detailPriceStandard: UILabel!
    @IBOutlet weak var detailLink: UIButton!
    
    
    var imageText: String = ""
    var titleText: String  = ""
    var authorText: String = ""
    var publisherText: String = ""
    var pubDateText: String = ""
    var descriptionText: String = ""
    var customerReviewRankText: Float = 0.0
    var priceStandard: Int = 0
    var link: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentSetting()
    }
    
    func contentSetting() {
        
        if let url = URL(string: imageText) {
            detailImageView.kf.setImage(with: url)
        } else {
            detailImageView.image = UIImage(systemName: "nosign")
        }
        
        detailTitle.text = titleText
        detailAuthor.text = authorText
        detailPublisher.text = publisherText
        
        detailPubDate.text = pubDateText
        detailDescription.text = descriptionText
        
        detailCustomerReviewRank.text = String(describing: customerReviewRankText)
        detailPriceStandard.text = String(describing: priceStandard)
    }
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        print("link button click!")
    }
    
}
