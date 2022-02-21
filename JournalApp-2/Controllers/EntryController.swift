//
//  EntryController.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import Foundation

class EntryController {
    
    // CRUD : Create, Read, Update, Delete
    
    //create
    static func createEntry(title: String, body: String, journal: Journal) {
        // create new instance of an entry with what was passed in
        let timestamp = Date()
        let newEntry = Entry(title: title, body: body, timestamp: timestamp)
        // add the new entry to entries array
        journal.entries.append(newEntry)    // appends to journal that was passed in
        JournalController.shared.saveToPersistenceStore()
    }
    
    //delete
    static func deleteEntry(entry: Entry, journal: Journal) {
        // object must be equatable to use .firstIndex(of: ) to find match in array
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        // remove the song from array
        journal.entries.remove(at: index)
        JournalController.shared.saveToPersistenceStore()
    }
    
}
