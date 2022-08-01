//
//  FavoriteTableViewCell.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier = "FavoriteTableViewCell"

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteTitle: UILabel!
    @IBOutlet weak var favoriteAuthor: UILabel!
    @IBOutlet weak var favoritePublisher: UILabel!
    
    func configureCell(row: UserFavoriteBook) {
        favoriteImageView.layer.borderWidth = 0
        favoriteImageView.layer.borderColor = CGColor.init(red: 256, green: 256, blue: 256, alpha: 1)
        
        favoriteImageView.layer.masksToBounds = false
        favoriteImageView.layer.shadowColor = UIColor.gray.cgColor
        favoriteImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        favoriteImageView.layer.shadowOpacity = 0.3
        
        favoriteTitle.text = row.bookTitle
        favoriteAuthor.text = row.author
        favoritePublisher.text = row.publisher
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
