//
//  ChapterTableViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/26/24.
//

import UIKit
import RealmSwift
class ChapterViewController: UITableViewController {
    @IBOutlet weak var chapterView: UITableView!
    var chapters = ChapterDataManager.shared.chapters
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User Realm Section file location: \(realm.configuration.fileURL!.path)")
        for i in 0..<chapters.count {
            let chapterNumber = chapters[i].number
            let filterSections = realm.objects(Section.self).filter("chapter == %d AND topic == nil",chapterNumber ?? 0).distinct(by: ["content"])
            chapters[i].contents = filterSections.map { $0.content }
            chapters[i].section = filterSections.map { $0.section }
        }
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    
    //MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chapters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chapters[section].open {
            print(chapters[section].contents?.count ?? 0)
            return (chapters[section].contents?.count ?? 0) + 1
        } else {
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ensure the section index is within bounds of tableViewData
        guard indexPath.section < chapters.count else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell") else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            // Display the title of the chapter
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.text = chapters[indexPath.section].title
            cell.textLabel?.textColor = .black // Ensure text is visible
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        } else {
            let dataIndex = indexPath.row - 1
            
            // Safety check: Ensure the dataIndex is within bounds of the contents array
            if let contents = chapters[indexPath.section].contents,
               dataIndex < contents.count {
                cell.textLabel?.text = "   " + contents[dataIndex]
                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                cell.textLabel?.text = "Unknown Content"
                print("Error: Content index out of bounds.")
            }
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            chapters[indexPath.section].open.toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            //Perform SectionView
            performSegue(withIdentifier: "showSection", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSection" {
            if let vc = segue.destination  as? SectionViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    var selectedChapter = chapters[indexPath.section].number
                    var selectedSection = chapters[indexPath.section].section?[indexPath.row - 1]
                    
                    
                    vc.selectedChapter = selectedChapter
                    vc.selectedSection = selectedSection
                }
            }
        }
    }
}


