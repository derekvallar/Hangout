//
//  AddMembersViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/31/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import CoreData
import FBSDKCoreKit
import UIKit

class AddMembersViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)

    var userList = [User]()
    var filteredUsers = [User]()
    var selectedUsers = [User]()

    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBAction func doneButtonAction(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let group = Group(context: context)
        group.initData(selectedUsers)

        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        performSegue(withIdentifier: "unwindToGroupsListView", sender: sender)
    }

    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true

        tableView.tableHeaderView = searchController.searchBar

        doneButton.isEnabled = false

        if FBSDKAccessToken.current() != nil {
            print("FB Token exists")
            let request = FBSDKGraphRequest.init(graphPath: "me/friends", parameters: nil)

            request?.start(completionHandler: {
                (connection: FBSDKGraphRequestConnection?, result: Any?, error: Error?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    print("Got Friends!")
                    print(result)
                }
            })
        }
        else {
            print("FB Token doesn't exists")
        }
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

        if selectedUsers.contains(cell.user) && cell.accessoryView == nil {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "green_checkmark"))
        }
        else if !selectedUsers.contains(cell.user) && cell.accessoryView != nil {
            cell.accessoryView = nil
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)! as! UserTableCell

        if cell.accessoryView == nil {
            cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "green_checkmark"))

            selectedUsers.append(cell.user)

            if !doneButton.isEnabled {
                doneButton.isEnabled = true
            }
        }
        else {
            cell.accessoryView = nil

            let user = cell.user!
            selectedUsers = selectedUsers.filter() { $0 != user }

            if selectedUsers.count == 0 {
                doneButton.isEnabled = false
            }
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

            if i.username!.localizedCaseInsensitiveContains(text) {
                return true
            }
            return false
        })

        tableView.reloadData()
    }
}

extension AddMembersViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.setShowsCancelButton(false, animated: false)
    }
}
