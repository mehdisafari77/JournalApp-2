//
//  Journal.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import Foundation

class Journal: Codable {
    let name: String
    var entries: [Entry]
    
    init(name: String, entries: [Entry] = []) {
        self.name = name
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.name == rhs.name && lhs.entries == rhs.entries
    }
}

