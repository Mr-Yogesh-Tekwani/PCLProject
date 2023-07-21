//
//  AssignedCustomersViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/20/23.
//

import UIKit

class AssignedCustomersViewController: UIViewController, UITableViewDataSource {
    
    var tableView = UITableView()
    var customerData: [String] = ["Customer 1", "Customer 2", "Customer 3", "Customer 4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = customerData[indexPath.row]
        return cell
    }
}
