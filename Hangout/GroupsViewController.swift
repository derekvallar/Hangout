//
//  SecondViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/13/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class GroupsViewController: UITableViewController {

    @IBOutlet var GroupTable: UITableView!
    @IBOutlet weak var AddGroupButton: UIBarButtonItem!

    let searchController = UISearchController(searchResultsController: nil)
    var groups:[Group] = groupList
    var filteredGroups:[Group] = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true

        self.navigationItem.titleView = searchController.searchBar
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredGroups.count
        }
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HangoutGroupCell", for: indexPath)
            as! HangoutGroupCell

        let group: Group
        if searchController.isActive && searchController.searchBar.text != "" {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
        cell.group = group

        return cell
    }
}

extension GroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        filteredGroups = groups.filter({ (i: Group) -> Bool in
            if i.name!.localizedCaseInsensitiveContains(text) {
                return true
            }

            for name in i.members! {
                if name.localizedCaseInsensitiveContains(text) {
                    return true
                }
            }
            return false
        })

        print(filteredGroups)
        tableView.reloadData()
    }
}
