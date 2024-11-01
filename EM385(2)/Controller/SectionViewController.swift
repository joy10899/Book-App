//
//  SectionViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/21/24.
//


import Foundation
import UIKit
import RealmSwift

class SectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sections: Results<Section>?
    var realm: Realm!
    var selectedChapter: Int?
    var selectedSection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 44
        
        
        do {
            self.realm = try Realm()
            print("User Realm Section file location: \(realm.configuration.fileURL!.path)")
            loadSectionsFromRealm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Now load the sections after view will appear (and values are set)
        loadSectionsFromRealm()
        print("viewWillAppear")
    }

    
    // Load Data from Realm
    func loadSectionsFromRealm() {
        guard let selectedChapter = selectedChapter, let selectedSection = selectedSection else {
                    print("Chapter or section not set.")
                    return
                }
        sections = realm.objects(Section.self).filter("chapter == %d AND section == %@", selectedChapter, selectedSection)
        tableView.reloadData()
    }
}
/*
// MARK: - Navigation
*/
extension SectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath)
        if let sectionContent = sections?[indexPath.row].content {
            cell.textLabel?.text = sectionContent
            cell.textLabel?.numberOfLines = 0
            cell.sizeToFit()
            cell.layoutIfNeeded()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

    

   


