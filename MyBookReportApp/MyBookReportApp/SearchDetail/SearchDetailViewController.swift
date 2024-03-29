//
//  SearchDetailViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/23.
//

import UIKit
import Kingfisher
import RealmSwift

class SearchDetailViewController: UIViewController {
    
    static let identifier = "SearchDetailViewController"
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserRecentBook>!
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailAuthor: UILabel!
    @IBOutlet weak var detailPublisher: UILabel!
    
    @IBOutlet weak var detailPubDate: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBOutlet weak var detailCustomerReviewRank: UILabel!
    @IBOutlet weak var detailReviewCount: UILabel!
    @IBOutlet weak var detailPriceStandard: UILabel!
    @IBOutlet weak var detailLink: UIButton!
    
    var imageText: String = ""
    var titleText: String  = ""
    var authorText: String = ""
    var publisherText: String = ""
    var pubDateText: String = ""
    var descriptionText: String = ""
    var customerReviewRank: Float = 0.0
    var reviewCount: Int = 0
    var priceStandard: Int = 0
    var linkText: String = ""
    var favoriteBool: Bool = false
    var nowBool: Bool = false
    var isbnText: String = ""
    
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
        imageSetting()
        
        let floatingDimViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(floatingDimViewSetting(_:)))
        floatingDimView.addGestureRecognizer(floatingDimViewGesture)
        
        tasks = localRealm.objects(UserRecentBook.self)
        print(localRealm.configuration.fileURL)
        
        let task = UserRecentBook(bookTitle: titleText,
                                  author: authorText,
                                  publisher: publisherText,
                                  image: imageText,
                                  pubDate: pubDateText,
                                  descriptionBook: descriptionText,
                                  customerReviewRank: customerReviewRank,
                                  reviewCount: reviewCount,
                                  priceStandard: priceStandard,
                                  link: linkText,
                                  writeDate: Date(),
                                  isbn: isbnText)
        
        try! self.localRealm.write {
            self.localRealm.add(task)
        }
    }
    
    func contentSetting() {
        if let url = URL(string: imageText) {
            detailImageView.kf.setImage(with: url)
        } else {
            detailImageView.image = UIImage(systemName: "nosign")
        }
        
        detailImageView.layer.borderWidth = 0
        detailImageView.layer.masksToBounds = false
        detailImageView.layer.shadowColor = UIColor.gray.cgColor
        detailImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        detailImageView.layer.shadowOpacity = 0.3
        
        detailTitle.text = titleText
        detailAuthor.text = authorText
        detailPublisher.text = publisherText
        
        detailPubDate.text = pubDateText
        detailDescription.text = descriptionText
        
        detailCustomerReviewRank.text = String(describing: customerReviewRank)+"/10"
        
        let reviewCount = String(describing: reviewCount)
        detailReviewCount.text = "(\(reviewCount)명)"
        detailPriceStandard.text = String(describing: priceStandard)+"원"
        
        detailLink.layer.cornerRadius = 5
    }
    
    func imageSetting() {
        let thisBook = localRealm.objects(UserFavoriteBook.self).filter("isbn == '\(isbnText)'")
        
        if !thisBook.isEmpty {
            let image = thisBook.first!.favorite ? UIImage(named: "like_circle") : UIImage(named: "dislike")
            heartButton.setImage(image, for: .normal)
        }
    }
    
    @objc func floatingDimViewSetting(_ gesture: UITapGestureRecognizer) {
        // floating 버튼 하나만 보이게 하기
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
        
        isShowFloating = !isShowFloating
        
        let image = isShowFloating ? UIImage(named: "plus") : UIImage(named: "plus_float")
        let rotation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 4)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) { [self] in
            self.floatingButton.setImage(image, for: .normal)
            self.floatingButton.transform = rotation
        }
    }
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SearchDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
        
        vc.linkText = linkText
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func floatingButtonClicked(_ sender: UIButton) {
        if isShowFloating { // true 일때 (floating 버튼이 보이는 상태) : floating 버튼 하나만 보이게 하기
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
        } else { // false 일때 : floating 버튼을 펼치기
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
        
        let image = isShowFloating ? UIImage(named: "plus") : UIImage(named: "plus_float")
        let rotation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 4)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) {
            sender.setImage(image, for: .normal)
            sender.transform = rotation
        }
    }
    
    @IBAction func heartButtonClicked(_ sender: UIButton) {
        let task = UserFavoriteBook(bookTitle: detailTitle.text!,
                                    author: detailAuthor.text!,
                                    publisher: detailPublisher.text!,
                                    image: imageText,
                                    pubDate: detailPubDate.text!,
                                    descriptionBook: detailDescription.text!,
                                    customerReviewRank: customerReviewRank,
                                    reviewCount: reviewCount,
                                    priceStandard: priceStandard,
                                    link: linkText,
                                    favorite: true,
                                    now: nowBool,
                                    writeDate: Date(),
                                    isbn: isbnText)
        
        try! localRealm.write {
            let thisBook = localRealm.objects(UserFavoriteBook.self).filter("isbn == '\(isbnText)'")
            
            if thisBook.isEmpty{
                // 책 자체가 없으면 넣기
                localRealm.add(task)
                heartButton.setImage(UIImage(named: "like_circle"), for: .normal)
            } else {
                // 책이 전에 favorite 컬럼에 있으면 찾아서 상태 바꿔주기
                // 어차피 같은 책은 하나밖에 없어서 first로 하면 하나 있는거 나옴
                if thisBook.first?.favorite == true {
                    thisBook.first?.favorite = false
                    thisBook.first?.writeDate = Date()
                    heartButton.setImage(UIImage(named: "dislike"), for: .normal)
                    
                } else {
                    thisBook.first?.favorite = true
                    thisBook.first?.writeDate = Date()
                    heartButton.setImage(UIImage(named: "like_circle"), for: .normal)
                }
            }
        }
    }
    
    @IBAction func pencilButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WriteViewController.identifier) as! WriteViewController
        
        vc.titleText = titleText
        vc.authorText = authorText
        vc.imageText = imageText
        vc.isbnText = isbnText
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
