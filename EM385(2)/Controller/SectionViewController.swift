//
//  SectionViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/21/24.
//


import Foundation
import UIKit
import RealmSwift
import PDFKit

class SectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var sections: Results<Section>?
    var realm: Realm!
    var selectedChapter: Int?
    var selectedSection: String?
    var pageStart: Int?
    var pageEnd: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        shareButton.target = self
//        print("shareButton initialize")
//        shareButton.action = #selector(shareContent)
//        print("Set action for share Button")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        
        do {
            self.realm = try Realm()
            print("User Realm Section file location: \(realm.configuration.fileURL!.path)")
            loadSectionsFromRealm()
            shareButton.target = self
            print("shareButton initialize")
            shareButton.action = #selector(shareContent)
            print("Set action for share Button")
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    
    // Load Data from Realm
    func loadSectionsFromRealm() {
        guard let selectedChapter = selectedChapter, let selectedSection = selectedSection else {
            print("Chapter or section not set.")
            return
        }
        sections = realm.objects(Section.self).filter("chapter == %d AND section == %@",selectedChapter, selectedSection)
        pageStart = sections?.first?.pageStart ?? 1
        print(pageStart)
        pageEnd = sections?.first?.pageEnd ?? 1
        print(pageEnd)
        tableView.reloadData()
    }
    
    @objc func shareContent() {
        print("Share Button Pressed")
        
        guard let pageStart = pageStart, let pageEnd = pageEnd else {
            print("Error: Page range not set.")
            return
        }
        
        if pageStart < 0 || pageEnd < pageStart {
            print("Error: Invalid page range.")
            return
        }
        
        guard let fileURL = Bundle.main.url(forResource: "SECTION 1", withExtension: "pdf") else {
            print("Error: PDF file not found")
            return
        }
        
        guard let originalPDF = PDFDocument(url: fileURL) else {
            print("Failed to initialize PDFDocument")
            return
        }
        
        let newPDF = PDFDocument()
        for pageIndex in pageStart...pageEnd {
            if let page = originalPDF.page(at: pageIndex) {
                newPDF.insert(page, at: newPDF.pageCount)
            }
        }
        
        let tempPDF = FileManager.default.temporaryDirectory.appendingPathComponent("CurrentSection.pdf")
        newPDF.write(to: tempPDF)
        
        let activityViewController = UIActivityViewController(activityItems: [tempPDF], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact]
        present(activityViewController, animated: true, completion: nil)
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






