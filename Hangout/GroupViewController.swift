//
//  GroupViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/8/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    var group: Group!
    var hangoutList: [Hangout]!
    @IBOutlet weak var createAHangoutView: UIView!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func SearchButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let hangout = Hangout(context: context)
        hangout.name = "Firestones"
        hangout.date = "Nov 2, 1994"
        hangout.address = "My House"
        hangout.group = group
        (UIApplication.shared.delegate as! AppDelegate).saveContext()



        updateHangoutData()
    }

    @IBAction func SuggestButton(_ sender: Any) {

    }


    // MARK: - Functions

    override func viewDidLoad() {
        navigationItem.title = group.name
        navigationItem.backBarButtonItem?.title = ""

        createAHangoutView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        createAHangoutView.layer.shadowRadius = 4
        createAHangoutView.layer.shadowOpacity = 0.25

        updateHangoutData()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateHangoutData()
    }

    func updateHangoutData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let groups = try context.fetch(Group.fetchRequest(group.uniqueID))
            group = groups.first!
        }
        catch {
            print("Fetching Group data failed.")
        }

        hangoutList = group.hangouts?.allObjects as! [Hangout]
        tableView.reloadData()
    }
}


// MARK: - UITableView

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return hangoutList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HangoutTableCell", for: indexPath)
            as! HangoutTableCell

        cell.hangout = hangoutList[indexPath.row]
        return cell
    }
}
