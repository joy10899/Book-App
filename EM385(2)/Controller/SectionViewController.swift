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
    var section: Section
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
        // Configure Realm with migration logic
                let config = Realm.Configuration(
                    schemaVersion: 3, // Increment this number when you make changes to the schema
                    migrationBlock: { migration, oldSchemaVersion in
                        if oldSchemaVersion < 2 {
                            // Perform the migration here if needed
                            migration.enumerateObjects(ofType: Section.className()) { oldObject, newObject in
                                // Set default values for new properties if necessary

                            }
                        }
                    }
                )
                
                // Set the new configuration as the default Realm configuration
                Realm.Configuration.defaultConfiguration = config
        
        do {
            self.realm = try Realm()
            print("User Realm Section file location: \(realm.configuration.fileURL!.path)")
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
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

    

   


