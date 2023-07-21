//
//  DriverDetailsViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit

class DriverDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var driverDetailsViewModel : DriverDetailsViewModel?
    var clientManager = ClientManager()
    var allDriversArray: GetAvailableDriverArray? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        driverDetailsViewModel?.getData()
        self.title = "Driver Details"
        // Add the "+" button to the navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewDriverButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        // Register the default UITableViewCell (you can use a custom cell if needed)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Add the table view to the view controller's view and set up constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDriversArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = allDriversArray?[indexPath.row].driverName ?? ""
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let fullString = allDriversArray?[indexPath.row].driverName
        let words = fullString?.components(separatedBy: " ")
        
        showUpdateDriverPopup(
            firstName: words?.first ?? "",
            lastName: words?[1] ?? "",
            drId: (allDriversArray?[indexPath.row].driverID)!,
            mobileNumber: allDriversArray?[indexPath.row].phoneNumber  ?? "")
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the element from the dataArray
            guard let drId = allDriversArray?[indexPath.row].driverID
            else{
                return
            }
            
            clientManager.deleteDriver(dId: drId, completion: { check in
                if check == true {
                    DispatchQueue.main.async {
                        self.driverDetailsViewModel?.getData()
                        let alertController = UIAlertController(title: "Driver Deleted Successfully !", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Driver Delete Error !!!", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
            })
            
        }
        
    }
    
    
    // MARK: Driver Update Pop up
    
    // Function to show the Update Driver pop-up with pre-filled values
    func showUpdateDriverPopup(firstName: String, lastName: String, drId: Int, mobileNumber: String) {
        let alertController = UIAlertController(title: "Update Driver", message: nil, preferredStyle: .alert)
        
        // Create text fields for first name, last name, and mobile number with the provided values
        alertController.addTextField { textField in
            textField.text = firstName
            textField.placeholder = "First Name"
        }
        
        alertController.addTextField { textField in
            textField.text = lastName
            textField.placeholder = "Last Name"
        }
        
        alertController.addTextField { textField in
            textField.text = mobileNumber
            textField.placeholder = "Mobile Number"
            textField.keyboardType = .phonePad
        }
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.showUpdateDriverPopup(firstName: firstName, lastName: lastName, drId: drId, mobileNumber: mobileNumber)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let firstName = alertController.textFields?[0].text,
               let lastName = alertController.textFields?[1].text,
               let mobileNumber = alertController.textFields?[2].text {
                // Perform actions with the input data (e.g., send it to a server)
                print("Updated First Name: \(firstName)")
                print("Updated Last Name: \(lastName)")
                print("Updated Mobile Number: \(mobileNumber)")
                
                self.clientManager.updateDriver(fname: firstName, lname: lastName, dId: drId, phNum: mobileNumber, completion: { check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Driver Updated Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        self.driverDetailsViewModel?.getData()
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Driver Update Error !!!", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                })
            }
        }))
        
        // Present the pop-up
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: Add New Driver Pop up
    
    // Function to show the Update Driver pop-up
    func addNewDriverPopup() {
        let alertController = UIAlertController(title: "Add New Driver", message: nil, preferredStyle: .alert)
        
        // Add text fields for first name, last name, and mobile number
        alertController.addTextField { textField in
            textField.placeholder = "First Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Last Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Mobile Number"
            textField.keyboardType = .phonePad
        }
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.addNewDriverPopup()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let firstName = alertController.textFields?[0].text,
               let lastName = alertController.textFields?[1].text,
               let mobileNumber = alertController.textFields?[2].text {
                // Perform actions with the input data
                print("First Name: \(firstName)")
                print("Last Name: \(lastName)")
                print("Mobile Number: \(mobileNumber)")
                
                self.clientManager.addDriver(fname: firstName, lname: lastName, phNum: mobileNumber, completion: { check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Driver Added Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        self.driverDetailsViewModel?.getData()
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Driver Update Error !!!", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                })
                
            }
        }))
        
        // Present the pop-up
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // Function to call when the Update Driver button is tapped
    @objc func addNewDriverButtonTapped(_ sender: UIButton) {
        addNewDriverPopup()
    }
    
    
}

