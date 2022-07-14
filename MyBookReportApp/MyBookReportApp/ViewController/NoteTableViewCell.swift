//
//  NoteTableViewCell.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/29.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    static let identifier = "NoteTableViewCell"
    
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteAuthor: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteContent: UILabel!
    
    func configureCell(row: UserNote) {
        noteImageView.layer.borderWidth = 0
        noteImageView.layer.masksToBounds = false
        noteImageView.layer.shadowColor = UIColor.gray.cgColor
        noteImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        noteImageView.layer.shadowOpacity = 0.3
        
        noteView.layer.borderWidth = 0
        //noteView.layer.borderColor = CGColor.init(red: 214, green: 214, blue: 214, alpha: 1)
        noteView.layer.cornerRadius = 10
        noteView.layer.shadowColor = UIColor.gray.cgColor
        noteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        noteView.layer.shadowOpacity = 0.3
        
        noteTitle.text = row.bookTitle
        noteAuthor.text = row.author
        
        let writeDate = row.writeDate
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 d일 a HH:mm"
        format.locale = Locale(identifier:"ko_KR")
        let strDate = format.string(from: writeDate)
        noteDate.text = strDate
        noteContent.text = row.note
        noteContent.font = UIFont(name: "나눔손글씨 백의의 천사", size: 18)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
