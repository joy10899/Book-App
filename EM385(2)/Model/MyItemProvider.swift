//
//  MyItemProvider.swift
//  EM385(2)
//
//  Created by Joy on 11/22/24.
//


import Foundation
import UIKit
import UniformTypeIdentifiers

class MyItemProvider: UIActivityItemProvider {

    var fileURL: URL

        init(fileURL: URL) {
            self.fileURL = fileURL
            super.init(placeholderItem: fileURL)
        }

        override var item: Any {
            return fileURL
        }
        
        override func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
            return fileURL
        }
    }
