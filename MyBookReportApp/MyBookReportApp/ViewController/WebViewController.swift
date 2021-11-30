//
//  WebViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/30.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    static let identifier = "WebViewController"
    var linkText = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: linkText) else {
            print("ERROR")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
  

}
