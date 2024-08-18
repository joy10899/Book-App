//
//  Chapter.swift
//  EM385(2)
//
//  Created by Joy on 7/26/24.
//

import Foundation
import UIKit
import RealmSwift

struct Chapter {
    var open : Bool
    var title : String
    var number : Int?
    var section: [String]?
    var contents: [String]?
    
    let chapters = [
        Chapter(open: false, title: "1 Program Manager-03", number: 1),
                    Chapter(open: false, title: "2 Sanitation", number: 2),
                    Chapter(open: false, title: "3", number: 3)]
}
