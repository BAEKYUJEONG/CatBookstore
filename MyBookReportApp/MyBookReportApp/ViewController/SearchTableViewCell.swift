//
//  SearchTableViewCell.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookWriter: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    
    func configureCell(row: UserBook) {
        /*
        // shadow가 있으려면 layer.borderWidth 값이 필요 : 테두리 두께
        view.layer.borderWidth = 0
        // 테두리 밖으로 contents가 있을 때, 마스킹(true)하여 표출안되게 할것인지 마스킹을 off(false)하여 보일것인지 설정
        view.layer.masksToBounds = false
        // shadow 색상
        view.layer.shadowColor = UIColor.gray.cgColor
        // 현재 shadow는 view의 layer 테두리와 동일한 위치로 있는 상태이므로 offset을 통해 그림자를 이동시켜야 표출
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        // shadow의 투명도 (0 ~ 1)
        view.layer.shadowOpacity = 0.3
        
        view.layer.cornerRadius = 10.0
        view.layer.shadowRadius = 10.0
        */
        bookImageView.backgroundColor = .white
        bookImageView.layer.borderWidth = 3
        bookImageView.layer.borderColor = CGColor.init(red: 256, green: 256, blue: 256, alpha: 1)
        //bookImageView.layer.cornerRadius = 10.0
        //bookImageView.layer.shadowRadius = 10.0
        
        bookImageView.layer.masksToBounds = false
        bookImageView.layer.shadowColor = UIColor.gray.cgColor
        bookImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        bookImageView.layer.shadowOpacity = 0.3
        
        bookTitle.text = row.bookTitle
        bookWriter.text = row.author
        bookPublisher.text = row.publisher
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
