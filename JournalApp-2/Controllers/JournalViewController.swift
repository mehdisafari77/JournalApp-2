//
//  JournalViewController.swift
//  JournalApp-2
//
//  Created by Mehdi MMS on 20/02/2022.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var journalNameLabel: UITextField!
    @IBOutlet weak var journalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        journalTableView.delegate = self
        journalTableView.dataSource = self
        JournalController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalTableView.reloadData()
    }
    
    @IBAction func addJournalButton(_ sender: Any) {
        guard let journalName = journalNameLabel.text, !journalName.isEmpty else { return }
        JournalController.shared.createJournal(name: journalName)
        journalTableView.reloadData()
        journalNameLabel.text = ""
    }
    
    // MARK: - TableView Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.name
        cell.detailTextLabel?.text = "# \(journal.entries.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            JournalController.shared.deleteJournal(journal: journalToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEntryList" {
            guard let tappedIndexPath = journalTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryTableViewController else { return }
            let journal = JournalController.shared.journals[tappedIndexPath.row]
            destination.journal = journal
        }
    }
}
