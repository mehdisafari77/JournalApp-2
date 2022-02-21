//
//  Entry.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import Foundation

class Entry: Codable {
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date){
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

//make entry equatable
extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body
    }
}
