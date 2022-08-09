//
//  NoteViewController.swift
//  MyBookReportApp
//
//  Created by 백유정 on 2021/11/22.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    static let identifier = "NoteViewController"
    let localRealm = try! Realm()
    
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var noteEmptyView: UIView!
    
    var tasks: Results<UserNote>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "내 노트"
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
        tasks = localRealm.objects(UserNote.self).sorted(byKeyPath: "writeDate", ascending: false)
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteTableView.reloadData()
        emptyView()
        LongPress()
    }
    
    private func emptyView() {
        if tasks.count == 0 {
            noteEmptyView.isHidden = false
        } else {
            noteEmptyView.isHidden = true
        }
    }
    
    private func LongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        noteTableView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: noteTableView)
            if let indexPath = noteTableView.indexPathForRow(at: touchPoint) {
                
                let alert = UIAlertController(title: "노트 삭제", message: "노트를 삭제하겠냥?", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                let delete = UIAlertAction(title: "삭제", style: .default) { [weak self] delete in
                    guard let self = self else { return }
                    let row = self.tasks[indexPath.row]
                    
                    try! self.localRealm.write {
                        self.localRealm.delete(row)
                        self.noteTableView.deleteRows(at: [indexPath], with: .automatic)
                        if self.tasks.count == 0 {
                            self.noteEmptyView.isHidden = false
                        }
                    }
                }
                
                alert.addAction(cancel)
                alert.addAction(delete)
                self.present(alert, animated: true)
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Write", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WriteViewController.identifier) as! WriteViewController
        
        let row = tasks[indexPath.row]
        
        vc.userNote = row
        vc.noteText = row.note
        vc.titleText = row.bookTitle
        vc.authorText = row.author
        vc.imageText = row.image
        vc.isbnText = row.isbn
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
