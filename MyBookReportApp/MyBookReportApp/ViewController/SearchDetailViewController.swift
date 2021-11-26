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
    
    
    // floating button
    @IBOutlet weak var floatingStackView: UIStackView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var pencilButton: UIButton!
    
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.alpha = 0
        view.isHidden = true
        
        self.view.insertSubview(view, belowSubview: self.floatingStackView)
        
        return view
    }()
    
    var isShowFloating: Bool = false
    
    lazy var buttons: [UIButton] = [self.heartButton, self.pencilButton]
    
    
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
    
    @IBAction func floatingButtonClicked(_ sender: UIButton) {
        
        if isShowFloating {
            
            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3) {
                    button.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.floatingDimView.alpha = 0
            }) { (_) in
                self.floatingDimView.isHidden = true
            }
            
        } else {
            
            buttons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0
                
                UIView.animate(withDuration: 0.3) {
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                }
            }
            
            self.floatingDimView.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.floatingDimView.alpha = 1
            }
            
        }
        
        isShowFloating = !isShowFloating
        
        let image = isShowFloating ? UIImage(named: "cancel") : UIImage(named: "plus")
        let rotation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 2)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) {
            sender.setImage(image, for: .normal)
            sender.transform = rotation
        }
    }
    
}
