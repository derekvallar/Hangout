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
    var filteredGroups:[Group] = [Group]()
    var groupList:[Group] = [Group]()

    override func viewDidLoad() {
        print("ViewDidLoad()")
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true

        self.navigationItem.titleView = searchController.searchBar
    }

    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear()")

        getGroupData()
        tableView.reloadData()
        print(groupList)
    }

    func getGroupData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            groupList = try context.fetch(Group.fetchRequest())
        }
        catch {
            print("Fetching Group data failed.")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredGroups.count
        }
        return groupList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableCell", for: indexPath)
            as! GroupTableCell

        let group: Group
        if searchController.isActive && searchController.searchBar.text != "" {
            group = filteredGroups[indexPath.row]
        } else {
            group = groupList[indexPath.row]
        }
        cell.group = group

        return cell
    }
}

extension GroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        filteredGroups = groupList.filter({ (i: Group) -> Bool in

            for user in i.members?.allObjects as! [User] {
                if user.firstname!.localizedCaseInsensitiveContains(text) {
                    return true
                }

                if user.username!.localizedCaseInsensitiveContains(text) {
                    return true
                }
            }

            return false
        })

        print(filteredGroups)
        tableView.reloadData()
    }
}
