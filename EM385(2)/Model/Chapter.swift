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
}

class ChapterDataManager {
    static let shared = ChapterDataManager()
        
        var chapters: [Chapter] = [
            Chapter(open: false, title: "1 Program Manager-03", number: 1),
            Chapter(open: false, title: "2 Sanitation", number: 2),
            Chapter(open: false, title: "3 Medical and First Aid", number: 3),
            Chapter(open: false, title: "4 Temporary Facilities", number: 4),
            Chapter(open: false, title: "5 Personal Protective and Safety Equipment", number: 5),
            Chapter(open: false, title: "6 Hazardous or Toxic Agents and Environments", number: 6),
            Chapter(open: false, title: "7 Lightning", number: 7),
            Chapter(open: false, title: "8 Accident Prevention Signs", number: 8),
            Chapter(open: false, title: "9 Fire Prevention and Protection", number: 9),
            Chapter(open: false, title: "10 Welding and Cutting", number: 10),
            Chapter(open: false, title: "11 Electrical", number: 11),
            Chapter(open: false, title: "12 Control of Hazardous Energy", number: 12),
            Chapter(open: false, title: "13 Hand and Power Tools", number: 13),
            Chapter(open: false, title: "14 Material Handling, Storage and Disposal", number: 14),
            Chapter(open: false, title: "15 Rigging", number: 15),
            Chapter(open: false, title: "16 Load Handling Equipment (LHE)", number: 16),
            Chapter(open: false, title: "17 Conveyors", number: 17),
            Chapter(open: false, title: "18 Vehicles, Machinery and Equipment", number: 18),
            Chapter(open: false, title: "19 Floating Plant and Marine Activities", number: 19),
            Chapter(open: false, title: "20 Pressurized Equipment and Systems", number: 20),
            Chapter(open: false, title: "21 Fall Protection", number: 21),
            Chapter(open: false, title: "22 Work Platforms and Scaffolding", number: 22),
            Chapter(open: false, title: "23 Demolition, Renovation and Re-Occupancy", number: 23),
            Chapter(open: false, title: "24 Safe Access", number: 24),
            Chapter(open: false, title: "25 Excavation and Trenching", number: 25),
            Chapter(open: false, title: "26 Underground Construction (Tunnels), Shafts and Caissons", number: 26),
            Chapter(open: false, title: "27 Concrete, Masonry, Roofing and Residential Construction", number: 27),
            Chapter(open: false, title: "28 Steel Erection", number: 28),
            Chapter(open: false, title: "29 Blasting", number: 29),
            Chapter(open: false, title: "30 Diving Operations", number: 30),
            Chapter(open: false, title: "31 Tree Maintenance and Removal", number: 31),
            Chapter(open: false, title: "32 Airfield and Aircraft Operations", number: 32),
            Chapter(open: false, title: "33 Hazardous Waste Operations and Emergency Response (HAZWOPER)", number: 33),
            Chapter(open: false, title: "34 Confined Space Entry", number: 34),
            Chapter(open: false, title: "40APPA Accident Prevention Plans", number: 40),
            Chapter(open: false, title: "40APPB Emergency Operations", number: 40),
            Chapter(open: false, title: "40APPC Requesting Interpretations", number: 40),
            Chapter(open: false, title: "40APPD Requesting Waivers/Variances", number: 40),
            Chapter(open: false, title: "40APPE Assured Equipment Grounding Conductor Program", number: 40),
            Chapter(open: false, title: "40APPF2 Floating Plant and Marine Activities Diagrams", number: 40),
            Chapter(open: false, title: "40APPG Manning Levels for Dive Teams", number: 40)
        ]

    // Prevents external instantiation
        private init() {}
}
