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
    var tableViewData = [Chapter]()
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [
            Chapter(open: false, title: "1 Program Manager-03", number: 1),
            Chapter(open: false, title: "2 Sanitation", number: 2),
            Chapter(open: false, title: "3", number: 3)]
        

        do {
            self.realm = try Realm()
            print("User Realm file location: \(realm.configuration.fileURL!.path)")
            loadSectionsFromRealm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    // Load Data from Realm
    func loadSectionsFromRealm() {
        for i in 0..<tableViewData.count {
            let chapterNumber = tableViewData[i].number
            let filterSections = realm.objects(Section.self).filter("chapter == %d AND topic == nil",chapterNumber ?? 0)
            tableViewData[i].contents = filterSections.map { $0.content}
            tableViewData[i].section = filterSections.map {$0.section}
        }
        tableView.reloadData()
    }
    
    
    //MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].open {
            return (tableViewData[section].contents?.count ?? 0) + 1
        } else {
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Ensure the section index is within bounds of tableViewData
        guard indexPath.section < tableViewData.count else {
            return UITableViewCell()
        }
        
        guard let cell = chapterView.dequeueReusableCell(withIdentifier: "ChapterCell") else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            // Display the title of the chapter
            cell.textLabel?.text = tableViewData[indexPath.section].title
        } else {
            let dataIndex = indexPath.row - 1
            
            // Safety check: Ensure the dataIndex is within bounds of the contents array
            if let contents = tableViewData[indexPath.section].contents,
               dataIndex < contents.count {
                cell.textLabel?.text = contents[dataIndex]
            } else {
                cell.textLabel?.text = "Unknown Content"
                print("Error: Content index out of bounds.")
            }
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableViewData[indexPath.section].open.toggle()
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
                    var selectedChapter = tableViewData[indexPath.section].number
                    
                    var selectedSection = tableViewData[indexPath.section].section?[indexPath.row - 1]
                    
                    vc.selectedChapter = selectedChapter
                    vc.selectedSection = selectedSection
                }
            }
        }
    }
}

    
