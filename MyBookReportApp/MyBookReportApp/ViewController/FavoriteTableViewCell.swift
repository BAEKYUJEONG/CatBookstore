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
