//
//  SectionViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/17/24.
//

import Foundation
import UIKit
import RealmSwift

class SectionTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var section: Section
    var sections: Results<Section>?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.rowHeight = UITableView.automaticDimension
                tableView.estimatedRowHeight = 44
        do {
            self.realm = try Realm()
            print("User Realm file location: \(realm.configuration.fileURL!.path)")
            loadSectionsFromRealm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
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
        sections = realm.objects(Section.self)
        tableView.reloadData()
    }
}

extension SectionTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath)
        if let section = sections?[indexPath.row] {
            cell.textLabel?.text = section.content // Ensure your model has the correct property here
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}
