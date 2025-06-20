//
//  SectionSearchViewViewController.swift
//  EM385(2)
//
//  Created by Joy on 10/11/24.
//

import Foundation
import UIKit
import RealmSwift

class SectionSearchView: SectionViewController {
    var searchText: String = ""
    
//    func highlightSearch(searchText: String, content: String) -> NSAttributedString? {
//            let attributedContent = NSMutableAttributedString(string: content)
//            let contentNSString = NSString(string: content)
//            let range = NSRange(location: 0, length: contentNSString.length)
//    
//            // Iterate over the content and find ranges that match the search text
//            contentNSString.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired]) { (_, substringRange, _, _) in
//                let substring = contentNSString.substring(with: substringRange)
//    
//                if substring.caseInsensitiveCompare(searchText) == .orderedSame {
//                    attributedContent.addAttribute(.backgroundColor, value: UIColor.yellow, range: substringRange)
//                }
//            }
//    
//            return attributedContent
//        }
    
    func highlightSearch(content: String, keywordColors: [String: UIColor]) -> NSAttributedString {
        let attributedContent = NSMutableAttributedString(string: content)
        
        for (keyword, color) in keywordColors {
            let pattern = "\\b\(NSRegularExpression.escapedPattern(for: keyword))\\b"
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
                let range = NSRange(location: 0, length: content.utf16.count)
                for match in regex.matches(in: content, options: [], range: range) {
                    attributedContent.addAttribute(.backgroundColor, value: color, range: match.range)
                }
            }
        }
        
        return attributedContent
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath)
        cell.textLabel?.attributedText = nil
        cell.backgroundColor = .clear

        guard let sectionContent = sections?[indexPath.row].content else { return cell }

        var keywordColors: [String: UIColor] = [:]

        if let highlight = sections?[indexPath.row].highlight, highlight == true {
            let sec = findSection(in: sectionContent)
            let topic = findTopic(in: sectionContent)
            for sec in findSection(in: sectionContent) {
                keywordColors[sec] = .yellow
            }
            for topic in findTopic(in: sectionContent) {
                keywordColors[topic] = .cyan
            }
        }
        if !searchText.isEmpty { keywordColors[searchText] = .orange }

        cell.textLabel?.attributedText = highlightSearch(content: sectionContent, keywordColors: keywordColors)
        cell.textLabel?.numberOfLines = 0
        cell.layoutIfNeeded()

        return cell
    }


            
//        let highlight = sections?[indexPath.row].highlight
//            if let sectionContent = sections?[indexPath.row].content {
//                if highlight == true {
//                    let sec = findSection(in: sectionContent)
//                    let topic = findTopic(in: sectionContent)
//                    let color = checkHighlightColor(sec: sec, topic: topic)
//                    let keyword = checkHighlightText(sec: sec, topic: topic)
//                    cell.textLabel?.attributedText = highlightText(content: sectionContent, keywords: keyword, color: color)
//                    cell.textLabel?.numberOfLines = 0
//                    cell.sizeToFit()
//                    cell.layoutIfNeeded()
//                    cell.textLabel?.attributedText = highlightSearch(searchText: searchText, content: sectionContent)
//                    cell.textLabel?.numberOfLines = 0
//
//                    }
//                cell.textLabel?.attributedText = highlightSearch(searchText: searchText, content: sectionContent)
//                cell.textLabel?.numberOfLines = 0
//            }
//            // Forces layout update to calculate height
//            cell.layoutIfNeeded()
//            return cell
//        }
    
}





    


    

   


