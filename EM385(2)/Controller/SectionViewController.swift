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
    @IBAction func shareButton(_ sender: UIButton) {
        shareContent()
    }
    
    var sections: Results<Section>?
    let realm = try! Realm()
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
            guard let selectedChapter = selectedChapter, let selectedSection = selectedSection else {
                return
            }
            sections = realm.objects(Section.self).filter("chapter == %d AND section == %@",selectedChapter, selectedSection)
            tableView.reloadData()
        } catch {
            print("Error initializing Realm: \(error)")
        }
        
    }
    
    func highlightText(content: String, keywords: [String], color: UIColor) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: content)
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

    func highlightTextAsHTML(content: String, keywords: [String], color: UIColor) -> String {
        var highlightedContent = content
        for keyword in keywords {
            let coloredKeyword = "<span style=\"background-color: \(color.toHexString());\">\(keyword)</span>"
            highlightedContent = highlightedContent.replacingOccurrences(of: keyword, with: coloredKeyword)
        }
        return "<p>\(highlightedContent)</p>"
    }

    func generateHTMLFile() -> URL? {
        var htmlContent = "<html><head><meta charset=\"UTF-8\"><title>Highlighted Sections</title></head><body>"

        sections?.forEach { section in
            let sec = findSection(in: section.content)
            let topic = findTopic(in: section.content)
            let color = checkHighlightColor(sec: sec, topic: topic)
            let keyword = checkHighlightText(sec: sec, topic: topic)
            htmlContent += highlightTextAsHTML(content: section.content, keywords: keyword, color: color)
        }
        
        htmlContent += "</body></html>"
        
        // Save to a temporary file
        let fileName = "Sections \(selectedChapter)\(selectedSection).html"
        let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try htmlContent.write(to: filePath, atomically: true, encoding: .utf8)
            return filePath
        } catch {
            print("Error writing HTML file: \(error)")
            return nil
        }
    }

    func shareContent() {
        guard let fileURL = generateHTMLFile() else { return }
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
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
        // Reset cell properties to avoid reusing highlight styles
        cell.textLabel?.attributedText = nil
        cell.backgroundColor = .clear
        
        let highlight = sections?[indexPath.row].highlight
        if let sectionContent = sections?[indexPath.row].content {
            if highlight == true {
                let sec = findSection(in: sectionContent)
                let topic = findTopic(in: sectionContent)
                let color = checkHighlightColor(sec: sec, topic: topic)
                let keyword = checkHighlightText(sec: sec, topic: topic)
                cell.textLabel?.attributedText = highlightText(content: sectionContent, keywords: keyword, color: color)
                cell.textLabel?.numberOfLines = 0
                cell.sizeToFit()
                cell.layoutIfNeeded()
                }
            else {
                cell.textLabel?.text = sectionContent
                cell.textLabel?.numberOfLines = 0
                cell.sizeToFit()
                cell.layoutIfNeeded()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIColor {
    func toHexString() -> String {
        guard let components = cgColor.components else { return "#FFFF00" }
        // Default yellow
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}





