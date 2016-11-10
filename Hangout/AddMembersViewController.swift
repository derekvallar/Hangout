//
//  AddMembersViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/31/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import CoreData
import UIKit

class AddMembersViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)

    var userList = [User]()
    var filteredUsers = [User]()
    var selectedUsers = [User]()

    @IBAction func DoneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let group = Group(context: context)
        group.initData(selectedUsers)

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true

        self.tableView.tableHeaderView = searchController.searchBar

    }

    override func viewDidAppear(_ animated: Bool) {
        getUserData()
        tableView.reloadData()
    }

    func getUserData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            userList = try context.fetch(User.fetchRequest())
        }
        catch {
            print("Fetching User data failed.")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredUsers.count
        }
        return userList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath)
            as! UserTableCell

        let user: User
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredUsers[indexPath.row]
        } else {
            user = userList[indexPath.row]
        }
        cell.user = user

        if (cell.check ?? false) {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "green_checkmark"))
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)! as! UserTableCell

        if (cell.check == nil || cell.check! == false) {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "green_checkmark"))
            cell.check = true

            selectedUsers.append(cell.user)
        }
        else {
            cell.accessoryView = nil
            cell.check = false

            let user = cell.user!
            selectedUsers = selectedUsers.filter() { $0 != user }
        }

        cell.isSelected = false
    }
}

extension AddMembersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        filteredUsers = userList.filter({ (i: User) -> Bool in
            if i.name!.localizedCaseInsensitiveContains(text) {
                return true
            }

            if (i.username!.localizedCaseInsensitiveContains(text)) {
                return true
            }
            return false
        })

        tableView.reloadData()
    }
}
