//
//  NoteViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var noteEmptyView: UIView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserNote>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "내 노트"
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
        tasks = localRealm.objects(UserNote.self)
        print("테스크", tasks)
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteTableView.reloadData()
        emptyView()
    }
    
    func emptyView() {
        if tasks.count == 0 {
            noteEmptyView.isHidden = false
        } else {
            noteEmptyView.isHidden = true
        }
    }
    
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = noteTableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        
        cell.configureCell(row: row)
        
        if let url = URL(string: row.image) {
            cell.noteImageView.kf.setImage(with: url)
        } else {
            cell.noteImageView.image = UIImage(systemName: "nosign")
        }
        
        return cell
    }
    
}

