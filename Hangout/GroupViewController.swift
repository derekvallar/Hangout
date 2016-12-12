//
//  GroupViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/8/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import GooglePlaces
import UIKit

class GroupViewController: UIViewController {

    var group: Group!
    var hangoutList: [Hangout]!

    @IBOutlet weak var createAHangoutView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!

    @IBAction func unwindToGroupView(segue: UIStoryboardSegue) {}

    // MARK: - Functions

    override func viewDidLoad() {
        navigationItem.title = group.name
        navigationItem.backBarButtonItem?.title = ""

        setupViews()
        updateHangoutData()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateHangoutData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createAHangout" {
            let viewController = segue.destination as! EditHangoutViewController
            viewController.group = group
        }
    }

    func setupViews() {
        automaticallyAdjustsScrollViewInsets = false
        createAHangoutView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        createAHangoutView.layer.shadowRadius = 4
        createAHangoutView.layer.shadowOpacity = 0.25
    }

    func updateHangoutData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let groups = try context.fetch(Group.fetchRequest(group.id))
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

extension GroupViewController: RecommendationViewControllerDelegate {

    func didAddPlace(place: GMSPlace) {

    }
}
