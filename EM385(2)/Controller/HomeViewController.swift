//
//  HomeViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/21/24.
//

import UIKit
import PDFKit

class HomeViewController: UIViewController {
    
    @IBAction func ChapButtonPressed() {
        
    }
    @IBOutlet weak var shareButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
//        shareButton.target = self
//        shareButton.action = #selector(shareContent)
    }
//    @objc func shareContent(pageStart: Int, pageEnd: Int) {
//        print("Share Button Pressed")
//        let pageStart = 14
//        let pageEnd = 14
//        if pageStart < 0 || pageEnd < pageStart {
//                print("Error: Invalid page range.")
//                return
//            }
//        
//        guard let fileURL = Bundle.main.url(forResource: "SECTION 1", withExtension: "pdf") else {
//            print("Error: PDF file not found")
//            return
//        }
//        guard let originalPDF = PDFDocument(url: fileURL) else {
//            print("Failed to initialize PDFDocument")
//            return
//        }
//        let newPDF = PDFDocument()
//        for pageIndex in pageStart...pageEnd {
//            if let page = originalPDF.page(at: pageIndex) {
//                newPDF.insert(page, at: newPDF.pageCount)
//            }
//        }
//        guard pageStart >= 0, pageEnd < originalPDF.pageCount else {
//            print("Error: Page range out of bounds")
//            return
//        }
//
//        let tempPDF = FileManager.default.temporaryDirectory.appendingPathComponent("CurrentSection.pdf")
//        newPDF.write(to: tempPDF)
//        let myItemProvider = MyItemProvider(fileURL: fileURL)
//        
//        // Initialize the activity view controller
//        let activityViewController = UIActivityViewController(activityItems: [tempPDF], applicationActivities: nil)
//        
//        // Exclude certain activity types (optional)
//        activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact]
//        
//        // Present the activity view controller
//        present(activityViewController, animated: true, completion: nil)
//    }
}
