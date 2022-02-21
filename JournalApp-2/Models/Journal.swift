//
//  Journal.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import Foundation

// Needs to be codable to be able to save
class Journal: Codable {
    let name: String
    var entries: [Entry]
    
    // initialize as empty array
    init(name: String, entries: [Entry] = []) {
        self.name = name
        self.entries = entries
    }
}

//make entry equatable
extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.name == rhs.name && lhs.entries == rhs.entries
    }
}

