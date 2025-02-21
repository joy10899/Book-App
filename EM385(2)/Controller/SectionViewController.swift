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
import UniformTypeIdentifiers

class SectionViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBAction func shareButton(_ sender: UIButton) {
        shareContent()
    }
    
    var sections: Results<Section>?
//    var realm: Realm!
    let realm = try! Realm()
    var selectedChapter: Int?
    var selectedSection: String?
    var pageStart: Int?
    var pageEnd: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        
        do {
            loadSectionsFromRealm()
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
    
    func highlightText(content: String, keywords: [String], color: UIColor) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: content)
//            let highlightColor = UIColor.yellow // Change to your preferred color
            
            for keyword in keywords {
                let range = (content as NSString).range(of: keyword)
                if range.location != NSNotFound {
                    attributedString.addAttribute(.backgroundColor, value: color, range: range)
                }
            }
            return attributedString
        }
    
    func findTopic(in text: String) -> [String] {
        // Regular expression for "01.A.XX"
        let pattern = #"\d{2}\.[A-Z]\.\d{2}"#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            
            return matches.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func findSection(in text: String) -> [String] {
        //Regular expression for "01.A General."
        let pattern = #"(\d{2}\.[A-Z])\s+[A-Za-z0-9\s]+?\."#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            
            return matches.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func checkHighlightColor(sec: [String], topic: [String]) -> UIColor {
        if sec != [] {
            return UIColor.yellow
        } else {
            return UIColor.cyan
        }
    }
    
    func checkHighlightText(sec: [String], topic: [String]) -> [String] {
        if sec != [] {
            return sec
        } else {
            return topic
        }
    }
    
    func shareContent() {
        guard let pageStart = pageStart, let pageEnd = pageEnd else {
            print("Error: Page range not set.")
            return
        }
        guard let fileURL = Bundle.main.url(forResource: "SECTION 1", withExtension: "pdf"),
              let originalPDF = PDFDocument(url: fileURL) else {
            print("Error: PDF file not found or could not be loaded.")
            return
        }
        
        let newPDF = PDFDocument()
        for pageIndex in pageStart...pageEnd {
            if let page = originalPDF.page(at: pageIndex) {
                newPDF.insert(page, at: newPDF.pageCount)
            }
        }
        
        guard let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("Error: Could not fetch caches directory.")
            return
        }
        let tempPDF = directory.appendingPathComponent("CurrentSection.pdf")
        if !FileManager.default.fileExists(atPath: tempPDF.path) {
            print("Error: File not found at \(tempPDF.path)")
            return
        }

        do {
            try newPDF.write(to: tempPDF)
            print("PDF written to \(tempPDF)")
        } catch {
            print("Error writing PDF: \(error.localizedDescription)")
            return
        }
        
        let controller = UIDocumentInteractionController(url: tempPDF)
        controller.delegate = self
        controller.presentPreview(animated: true)
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? self
    }

//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//            return self
//        }
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
        // Reset cell properties to avoid reusing highlight styles
        cell.textLabel?.attributedText = nil
        cell.backgroundColor = .clear
        
        let highlight = sections?[indexPath.row].highlight
        if let sectionContent = sections?[indexPath.row].content {
            if highlight == true {
                let sec = findSection(in: sectionContent)
                let topic = findTopic(in: sectionContent)
                print("Section Matches: \(sec)")
                print("Topic Matches: \(topic)")
                let color = checkHighlightColor(sec: sec, topic: topic)
                let keyword = checkHighlightText(sec: sec, topic: topic)
                cell.textLabel?.attributedText = highlightText(content: sectionContent, keywords: keyword, color: color)
                cell.textLabel?.numberOfLines = 0
                cell.sizeToFit()
                cell.layoutIfNeeded()
                }
            else {
                cell.textLabel?.text = sectionContent
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}






