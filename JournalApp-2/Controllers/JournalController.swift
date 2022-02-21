//
//  JournalController.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import Foundation

class JournalController {
    static let shared = JournalController()
    
    var journals: [Journal] = []
    

    func createJournal(name: String) {
        let newJournal = Journal(name: name)
        journals.append(newJournal)
        // Save
        saveToPersistenceStore()
    }
    
    // Read
    
    // Delete
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        // Save
        saveToPersistenceStore()
    }
        
    private func persistentStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
   
   func saveToPersistenceStore() {
       do {
           let data = try JSONEncoder().encode(journals) // encode entries and save to data
           try data.write(to: persistentStore())   // write to URL by calling method above
       } catch {
           print("There was an error saving to the persistence store.")
           print(error)
           print(error.localizedDescription)
       }
   }
   
   func loadFromPersistenceStore() {
       do {
           let data = try Data(contentsOf: persistentStore())  // get data from persistence store
           let fetchedJournals = try JSONDecoder().decode([Journal].self, from: data)
           journals = fetchedJournals
       } catch {
           print("There was an error loading from the persistence store.")
           print(error)
           print(error.localizedDescription)
       }
   }
}

