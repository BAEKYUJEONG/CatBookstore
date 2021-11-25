//
//  HomeViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import Kingfisher
import FSPagerView

class HomeViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "홈"
        
        homeSearchBar.delegate = self
        pagerView.dataSource = self
        pagerView.delegate = self
    }
    
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let url = URL(string: arrayImageFisher[index])
        
        cell.imageView?.kf.setImage(with: url)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        /*
        let row = tasks[indexPath.row]
        
        if let url = URL(string: row.image) {
            cell.bookImageView.kf.setImage(with: url)
        } else {
            cell.bookImageView.image = UIImage(systemName: "nosign")
        }*/
        
        //cell.imageView?.image = ...
        //cell.textLabel?.text = ...
        /*
        // Create a pager view
        let pagerView = FSPagerView(frame: frame1)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(pagerView)
        */
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayImageFisher.count
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
