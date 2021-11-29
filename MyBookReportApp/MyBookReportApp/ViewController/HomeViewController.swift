//
//  HomeViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import FSPagerView
import RealmSwift

class HomeViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserBestBook>!
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.transformer = FSPagerViewTransformer(type: .invertedFerrisWheel)
            self.pagerView.itemSize = CGSize(width: 100, height: 150)
            //self.pagerView.interitemSpacing = 10
            self.pagerView.isInfinite = true
            self.pagerView.contentMode = .scaleAspectFit
            self.pagerView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            self.pagerView.automaticSlidingInterval = 3.0
        }
    }
    
    var arrayImageFisher = ["https://4.img-dpreview.com/files/p/E~TS590x0~articles/3925134721/0266554465.jpeg","https://kbob.github.io/images/sample-2.jpg"]
    
    var arrayBestSellerCover: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "홈"
        
        homeSearchBar.delegate = self
        pagerView.dataSource = self
        pagerView.delegate = self
        
        fetchBestSellerData()
        appendArrayList()
        
        tasks = localRealm.objects(UserBestBook.self)
        print("테스크", tasks)
        print("링크", localRealm.configuration.fileURL)
        
        try! localRealm.write {
            localRealm.delete(localRealm.objects(UserBestBook.self))
        }
    }
    
    func fetchBestSellerData() {
        
        let key = "195C74CC11F90BF250E1A5B4F89FA5FC997F3C9AB7F2F3DA1272D342B5B5DB8D"
        
        let url = "http://book.interpark.com/api/bestSeller.api?key=\(key)&categoryId=100&output=json"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["item"].arrayValue {
                    let title = item["title"].stringValue
                    let author = item["author"].stringValue
                    let publisher = item["publisher"].stringValue
                    let image = item["coverLargeUrl"].stringValue
                    
                    let pubDate = item["pubDate"].stringValue
                    let description = item["description"].stringValue
                    
                    let customerReviewRank = item["customerReviewRank"].floatValue
                    let reviewCount = item["reviewCount"].intValue
                    let priceStandard = item["priceStandard"].intValue
                    let link = item["link"].stringValue
                    
                    let isbn = item["isbn"].stringValue
                    
                    let task = UserBestBook(bookTitle: title,
                                        author: author,
                                        publisher: publisher,
                                        image: image,
                                        pubDate: pubDate,
                                        descriptionBook: description,
                                        customerReviewRank: customerReviewRank,
                                        reviewCount: reviewCount,
                                        priceStandard: priceStandard,
                                        link: link,
                                        favorite: false,
                                        now: false,
                                        isbn: isbn)
                    
                    try! self.localRealm.write {
                        self.localRealm.add(task)
                    }
                    
                }
                
            case .failure(let error):
                print("에러", error)
            }
        }
    }
    
    func appendArrayList() {
        for book in localRealm.objects(UserBestBook.self) {
            arrayBestSellerCover.append(book.image)
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let url = URL(string: arrayBestSellerCover[index])
        
        cell.imageView?.kf.setImage(with: url)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayBestSellerCover.count
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        // 셀이 선택 되었을 때
        
        // 1. storyboard
        let sb = UIStoryboard(name: "SearchDetail", bundle: nil)
        
        // 2. viewcontroller
        let vc = sb.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
        
        let row = tasks[index]
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
        
        // 3. Push
        self.navigationController?.pushViewController(vc, animated: true)
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
