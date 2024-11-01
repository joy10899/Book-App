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
    var sections: Results<Section>?
    var realm: Realm!
    var selectedChapter: Int?
    var selectedContent: String?
    var searchText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReusableCell")
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
        loadSectionsFromRealm()
    }
    
    /* Load Data from Realm
     */
    func loadSectionsFromRealm() {
        guard let selectedChapter = selectedChapter, let selectedSection = selectedContent else {
            print("Chapter or section not set.")
            return
        }
        sections = realm.objects(Section.self).filter("chapter == %d AND content == %@", selectedChapter, selectedContent ?? "")
        
        tableView.reloadData()
    }
    
    func highlightText(searchText: String, content: String) -> NSAttributedString? {
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
        
        return attributedContent
    }
}

extension SectionSearchView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        
        if let sectionContent = sections?[indexPath.row].content {
            
            cell.textLabel?.attributedText = highlightText(searchText: searchText, content: sectionContent)
            cell.textLabel?.numberOfLines = 0
        }
        // Forces layout update to calculate height
        cell.layoutIfNeeded()
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


    

   


