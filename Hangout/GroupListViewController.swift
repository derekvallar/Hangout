//
//  SecondViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/13/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class GroupListViewController: UITableViewController {

    @IBOutlet var GroupTable: UITableView!
    @IBOutlet weak var AddGroupButton: UIBarButtonItem!

    @IBAction func unwindToGroupsListView(segue: UIStoryboardSegue) {}

    let searchController = UISearchController(searchResultsController: nil)
    var filteredGroups:[Group] = [Group]()
    var groupList:[Group] = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true

        navigationItem.titleView = searchController.searchBar
    }

    override func viewDidAppear(_ animated: Bool) {
        getGroupData()
        tableView.reloadData()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showGroup") {
            let groupViewController = segue.destination as! GroupViewController
            groupViewController.group = (sender as! GroupTableCell).group
        }
    }
}


// MARK: - TableView Functions

extension GroupListViewController {

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


// MARK: - UISearchResultsUpdating

extension GroupListViewController: UISearchResultsUpdating {
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

        tableView.reloadData()
    }
}
