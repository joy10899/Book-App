//
//  Section.swift
//  EM385(2)
//
//  Created by Joy on 7/17/24.
//

import Foundation
import RealmSwift
class Section: Object {
    @Persisted var chapter: Int
    @Persisted var section: String
    @Persisted var topic: String?
    @Persisted var refOne: String?
    @Persisted var refTwo: String?
    @Persisted var refThree: String?
    @Persisted var content: String
}
