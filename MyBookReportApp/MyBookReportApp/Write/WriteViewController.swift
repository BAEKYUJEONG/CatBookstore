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
    
    var userNote = UserNote()
    var noteText: String = ""
    var titleText: String  = ""
    var authorText: String = ""
    var imageText: String = ""
    var isbnText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        contentSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if writeTextView.isEditable {
            navigationItem.leftBarButtonItem?.customView?.isHidden = true
        } else {
            navigationItem.leftBarButtonItem?.customView?.isHidden = false
        }
    }
    
    func contentSetting() {
        if let url = URL(string: imageText) {
            writeImageView.kf.setImage(with: url)
        } else {
            writeImageView.image = UIImage(systemName: "nosign")
        }
        
        writeTitle.text = titleText
        writeAuthor.text = authorText
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 d일 a HH:mm"
        format.locale = Locale(identifier:"ko_KR")
        
        writeTextView.layer.cornerRadius = 10
        writeTextView.font = UIFont(name: "나눔손글씨 백의의 천사", size: 22)
        
        if !noteText.isEmpty {
            writeTextView.text = noteText
            writeDate.text = format.string(from: userNote.writeDate)
        } else {
            let strDate = format.string(from: Date())
            writeDate.text = strDate
        }
    }
    
    @objc func cancelButtonClicked() {
        print("cancel 클릭")
        
        if writeTextView.text.isEmpty {
            // 내용이 없다면 닫기
            self.navigationController?.popViewController(animated: true)
        } else {
            // 아니면 alert 문구 띄우고 물어보고 닫기
            let alert = UIAlertController(title: "닫기", message: "정말로 닫을거냥?", preferredStyle: UIAlertController.Style.alert)
            let closeAction = UIAlertAction(title: "닫기", style: .default) {_ in
                self.navigationController?.popViewController(animated: true)
            }
            let writeAction = UIAlertAction(title: "이어쓰기", style: .default)
            
            alert.addAction(closeAction)
            alert.addAction(writeAction)
            
            present(alert, animated: false, completion: nil)
        }
    }
    
    @objc func saveButtonClicked() {
        if writeTextView.text.isEmpty {
            // 내용이 없다면 알림창뜨고 저장 안하기
            let alert = UIAlertController(title: "내용 없음", message: "내용이 없어 저장이 안된다냥!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            
        } else {
            if noteText.isEmpty {
                // 저장하기
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
            } else {
                // 수정하기
                guard let oldNote = localRealm.object(ofType: UserNote.self, forPrimaryKey: userNote._id) else { return }
                
                try? localRealm.write {
                    oldNote.note = writeTextView.text
                    localRealm.add(oldNote, update: .modified)
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        /*
        if writeTextView.text == "노트를 작성해주세요." {
             저장 안하기
             내용이 없다는 alert
             페이지 넘어가지 않기
        } else {
             저장하기
        }
        */
    }
}
