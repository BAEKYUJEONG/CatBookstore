//
//  WriteViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/28.
//

import UIKit
import RealmSwift

class WriteViewController: UIViewController {

    static let identifier = "WriteViewController"
    let localRealm = try! Realm()
    
    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var writeImageView: UIImageView!
    @IBOutlet weak var writeTitle: UILabel!
    @IBOutlet weak var writeAuthor: UILabel!
    @IBOutlet weak var writeDate: UILabel!
    
    var imageText: String = ""
    var titleText: String  = ""
    var authorText: String = ""
    var isbnText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        contentSetting()
        //placeholderSetting()
    }
    
    func contentSetting() {
        if let url = URL(string: imageText) {
            writeImageView.kf.setImage(with: url)
        } else {
            writeImageView.image = UIImage(systemName: "nosign")
        }
        
        writeTitle.text = titleText
        writeAuthor.text = authorText
        
        let nowDate = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 d일 a HH:mm"
        format.locale = Locale(identifier:"ko_KR")
        let strDate = format.string(from: nowDate)
        writeDate.text = strDate
        
        writeTextView.layer.cornerRadius = 10
        writeTextView.font = UIFont(name: "나눔손글씨 백의의 천사", size: 22)
    }
    
    @objc func cancelButtonClicked() {
        print("cancel 클릭")
        
        self.navigationController?.popViewController(animated: true)
        /*
        if writeTextView.text.isEmpty {
            // 내용이 없다면 닫기
            self.navigationController?.popViewController(animated: true)
        } else {
            // 아니면 alert 문구 띄우고 물어보고 닫기
        }
        */
    }
    
    @objc func saveButtonClicked() {
        print("save 클릭")
        
        if writeTextView.text.isEmpty { 
            
        } else { // 저장하기
            let nowDate = Date()
            
            let task = UserNote(bookTitle: titleText,
                                author: authorText,
                                image: imageText,
                                note: writeTextView.text!,
                                writeDate: nowDate,
                                isbn: isbnText)
            
            try! localRealm.write {
                localRealm.add(task)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        /*
        if writeTextView.text == "노트를 작성해주세요." {
            // 저장 안하기
            // 내용이 없다는 alert
            // 페이지 넘어가지 않기
        } else {
            // 저장하기
        }
        */
    }
}

/*
extension WriteViewController: UITextViewDelegate {
    
    func placeholderSetting() {
        writeTextView.delegate = self
        writeTextView.text = "노트를 작성해주세요."
        writeTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if writeTextView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if writeTextView.text.isEmpty {
            writeTextView.text = "노트를 작성해주세요."
            textView.textColor = UIColor.gray
        }
    }
    
}
*/
