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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
