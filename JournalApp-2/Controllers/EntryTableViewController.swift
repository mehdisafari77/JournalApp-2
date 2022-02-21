//
//  EntryTableViewController.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryBodyTextField: UITextView!
    
    var journal: Journal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addEntryButton(_ sender: Any) {
        // must unwrap using guard statement
        guard let entryTitle = entryTitleTextField.text,
              let entryBody = entryBodyTextField.text,
              // check that both required fields aren't empty
              !entryTitle.isEmpty,
              !entryBody.isEmpty,
              let journal = journal else { return }
        // calls createEntry() method in EntryController file
        EntryController.createEntry(title: entryTitle, body: entryBody, journal: journal)
        entryTitleTextField.text = ""
        entryBodyTextField.text = ""
        tableView.reloadData() // reload table after adding song
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journal?.entries.count ?? 0  //another way to unwrap since journal is optional here
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let journal = journal else { return cell }
        let entry = journal.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        cell.detailTextLabel?.text = formatter.string(from: entry.timestamp)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            // get the row that was swiped
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEntryDetails" {
            guard let tappedIndexPath = tableView.indexPathForSelectedRow, let journal = journal else { return }
            let entry = journal.entries[tappedIndexPath.row]
            if let detailVC = segue.destination as? EntryDetailViewController {
                detailVC.entry = entry
            }
        }
    }
}
