//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositories{
            DispatchQueue.main.async{
                print(5)
                self.tableView.reloadData()
                print(self.store.repositories.count)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)

        let repository:GithubRepository = self.store.repositories[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = repository.fullName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = store.repositories[indexPath.row].fullName
        let alertController = UIAlertController()
        ReposDataStore.toggleStar(for: selectedRepo) { (starred) in
            if starred == true {
                alertController.message = "You just starred \(selectedRepo)"
                alertController.accessibilityLabel = "You just starred \(selectedRepo)"
                
            }
            else {
                alertController.message = "You just unstarred \(selectedRepo)"
                alertController.accessibilityLabel = "You just unstarred \(selectedRepo)"
            }
        }
    }

}
