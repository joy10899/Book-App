//
//  SearchViewController.swift
//  EM385(2)
//
//  Created by Joy on 8/14/24.
//
import RealmSwift
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var tableViewData = [Chapter]()
    var section: Section
    var searchContents: Results<Section>?
    let realm = try! Realm()
    let data = UserDefaults()
    //    var selectedChapter : Int?
    //    var selectedSection : String?
    
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
        
        //Set up searchTableView delegate and datasource
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 44
    }
    
    //Funtion return chapter title
    func getTitle(chapterNumber : Int) -> String? {
        for chapter in tableViewData {
            if chapterNumber == chapter.number {
                print(chapter.title)
                return chapter.title
            }
        }
        return nil
    }
    
    //Function Highlight Text
    func highlightText(searchText: String, content: String) -> AttributedString? {
        guard !searchText.isEmpty else { return AttributedString(content) }
        
        let attributedContent = NSMutableAttributedString(string: content)
        let contentNSString = NSString(string: content)
        let range = NSRange(location: 0, length: contentNSString.length)
        
        // Iterate over the content and find ranges that match the search text
        contentNSString.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired]) { (_, substringRange, _, _) in
            let substring = contentNSString.substring(with: substringRange)
            
            if substring.caseInsensitiveCompare(searchText) == .orderedSame {
                attributedContent.addAttribute(.backgroundColor, value: UIColor.yellow, range: substringRange)
            }
        }
        
        return AttributedString(attributedContent)
    }
    
    //    Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSectionSearch" {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sectionSearchView")
//                segue.destination as? SectionSearchView {
            if let indexPath = searchTableView.indexPathForSelectedRow {
                //            let searchContents = searchContents {
                data.set(searchContents?[indexPath.row].chapter, forKey: "SelectedChapter")
                data.set(searchContents?[indexPath.row].content, forKey: "SelectedSection")
            }
//                    vc.selectedChapter = selectedChapter
//                    print("\(selectedChapter)")
//                    vc.selectedSection = selectedSection
//                    print("\(selectedSection)")
                self.show(vc, sender: nil)
                    
//                }
//            }
        }
        
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchContents?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        guard let searchContents = searchContents else { return cell}
        let chapterIntFormat = searchContents[indexPath.row].chapter
        cell.chapTitle.text = getTitle(chapterNumber: chapterIntFormat)
        cell.sectionTitle.text = "Section " + String(chapterIntFormat) + searchContents[indexPath.row].section
        cell.content.text = searchContents[indexPath.row].content
        cell.textLabel?.numberOfLines = 0
        cell.sizeToFit()
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showSectionSearch", sender: self)
        
    }
}



// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchContents = realm.objects(Section.self).filter("content CONTAINS %@", searchBar.text!, section.chapter, section.content)
        searchTableView.reloadData()
        print(searchContents ?? "searchButtonClicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty ?? true {
            loadContents()
            searchTableView.reloadData()
            print("text did change")
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    //    Model Manipulation Methods
    func loadContents() {
        
        // Ensure selectedChapter and selectedSection are set before querying Realm
        //        guard let selectedChapter = selectedChapter, let selectedSection = selectedSection else {
        //            print("Chapter or section not set.")
        //            return
        //        }
        
        // Fetch searchContents from Realm
        searchContents = searchContents?.filter("content CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "chapter", ascending: true)
        print(searchContents ?? "loadContents")
        //        searchContents = realm.objects(Section.self).filter("chapter == %d AND section == %@", selectedChapter, selectedSection)
        
        //        if searchContents?.isEmpty ?? true {
        //            print("No matching sections found in Realm for chapter: \(selectedChapter) and section: \(selectedSection)")
        //        }
        //
        searchTableView.reloadData()
    }
}





