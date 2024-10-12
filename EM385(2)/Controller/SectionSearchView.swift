//
//  SectionSearchViewViewController.swift
//  EM385(2)
//
//  Created by Joy on 10/11/24.
//

import Foundation
import UIKit
import RealmSwift

class SectionSearchView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var section: Section
    var sections: Results<Section>?
    var realm: Realm!
    var selectedChapter: Int?
    var selectedSection: String?
    let data = UserDefaults()
    
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
        
        selectedChapter = data.integer(forKey: "SelectedChapter")
        selectedSection = data.string(forKey: "SelectedSection")
        print("Chapter: '\(selectedChapter)'")
        print("Chapter: '\(selectedSection)'")
        // Now load the sections after view will appear (and values are set)
        loadSectionsFromRealm()
        print("viewWillAppear")
    }
    
    // Custom initializer
    init(section: Section) {
        self.section = section
        super.init(nibName: nil, bundle: nil)
    }
    
    // Required initializer for using with storyboard or XIB
    required init?(coder: NSCoder) {
        self.section = Section()
        super.init(coder: coder)
    }
    
    // Load Data from Realm
    func loadSectionsFromRealm() {
        print(selectedChapter)
//        guard let selectedChapter = selectedChapter, let selectedSection = selectedSection else {
//                    print("Chapter or section not set.")
//                    return
//                }
        sections = realm.objects(Section.self).filter("chapter == %d AND section == %@", selectedChapter, selectedSection)
        tableView.reloadData()
    }
}

extension SectionSearchView : UITableViewDelegate, UITableViewDataSource {
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


    

   


