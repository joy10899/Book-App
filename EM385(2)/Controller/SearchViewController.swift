//
//  SearchViewController.swift
//  EM385(2)
//
//  Created by Joy on 8/14/24.
//
import RealmSwift
import UIKit

class SearchViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var tableViewData = [Chapter]()
    var section: Section
    var searchContents: Results<Section>?
    var realm: Realm!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [
            Chapter(open: false, title: "1 Program Manager-03", number: 1),
            Chapter(open: false, title: "2 Sanitation", number: 2),
            Chapter(open: false, title: "3", number: 3)]
        // Define the migration block
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: Section.className()) { oldObject, newObject in
                    
                }
            }
        }
        
        // Set the new schema version and apply the migration
        let config = Realm.Configuration(
            schemaVersion: 3, // Increment this number with each schema change
            migrationBlock: migrationBlock
        )
        
        // Tell Realm to use this new configuration
        Realm.Configuration.defaultConfiguration = config
        
        
        do {
            self.realm = try Realm()
            print("User Realm file location: \(realm.configuration.fileURL!.path)")
            
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    //Funtion return chapter title
    func getTitle(chapterNumber : Int){
        for i in 0..<tableViewData.count {
            if chapterNumber == tableViewData[i].number {
                let chapterTitle = tableViewData[i].title
                
            }
        }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchContents?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cellAtSearchView", for: indexPath) as! SearchCell
        let chapterIntFormat = searchContents![indexPath.row].chapter
        var chapterStringFormat = String(chapterIntFormat)
        cell.chapNumber.text = chapterStringFormat
        cell.chapterTitle.text = getTitle(chapterNumber: chapterIntFormat)
        cell.sectionTitle.text = searchContents[indexPath.row].content[indexPath.row]
        return cell
    }
}
    


    // MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchContents = searchContents?.filter("content CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "chapter", ascending: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadContents()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
//    Model Manipulation Methods
    func loadContents() {
        searchContents = searchContents?.filter("content CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "chapter", ascending: true)
    }
}

   



