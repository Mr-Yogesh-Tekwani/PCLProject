//
//  VehicleDetailsViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class VehicleDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var vehicleDetailsViewModel : VehicleDetailsViewModel?
    var clientManager = ClientManager()
    var allVehicleArray : GetAvailableVehicleArray?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vehicleDetailsViewModel?.getData()
        self.title = "Vehicle Details"
        // Add the "+" button to the navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewVehicleButtonTapped))
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
        return allVehicleArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = allVehicleArray?[indexPath.row].plateNumber ?? ""
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        showUpdateVehiclePopup(
            vid: allVehicleArray?[indexPath.row].vehicleID ?? 0,
            plateNum: allVehicleArray?[indexPath.row].plateNumber ?? "",
            make: allVehicleArray?[indexPath.row].manufacturer ?? "",
            model: allVehicleArray?[indexPath.row].model ?? "")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the element from the dataArray
            guard let vid = allVehicleArray?[indexPath.row].vehicleID
            else{
                return
            }
            
            clientManager.deleteVehicle(vId: vid, completion: { check in
                if check == true {
                    DispatchQueue.main.async {
                        self.vehicleDetailsViewModel?.getData()
                        let alertController = UIAlertController(title: "Vehicle Deleted Successfully !", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Vehicle Delete Error !!!", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
            })
            
        }
        
    }
    
    
    // MARK: Vehicle Update Pop up
    
    func showUpdateVehiclePopup(vid: Int, plateNum: String?, make: String?, model: String?) {
        
        let alertController = UIAlertController(title: "Edit Vehicle", message: nil, preferredStyle: .alert)
        
        // Create text fields
        alertController.addTextField { textField in
            textField.text = plateNum
            textField.placeholder = "Licence Plate Number"
        }
        
        alertController.addTextField { textField in
            textField.text = make
            textField.placeholder = "Vehicle Make"
        }
        
        alertController.addTextField { textField in
            textField.text = model
            textField.placeholder = "Vehicle Model"
        }
        
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.showUpdateVehiclePopup(vid: vid ,plateNum: plateNum, make: make, model: model)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let platetf = alertController.textFields?[0].text,
               let maketf = alertController.textFields?[1].text,
               let modeltf = alertController.textFields?[2].text
            {
                self.clientManager.updateVehicle(manuf: maketf, model: modeltf, plateNum: platetf, vehicleId: vid, completion: { check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Vehicle Updated Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                            self.vehicleDetailsViewModel?.getData()
                        }
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Vehicle Update Error !!!", message: nil, preferredStyle: .alert)
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
    
    
    
    
    // MARK: Add New Vehicle Pop up
    
    func addNewVehicle() {
        
        let alertController = UIAlertController(title: "Add New Vehicle", message: nil, preferredStyle: .alert)
        
        // Create text fields
        alertController.addTextField { textField in
            textField.placeholder = "Licence Plate Number"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Vehicle Make"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Vehicle Model"
        }
        
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.addNewVehicle()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let platetf = alertController.textFields?[0].text,
               let maketf = alertController.textFields?[1].text,
               let modeltf = alertController.textFields?[2].text
            {
                self.clientManager.addVehicle(manuf: maketf, model: modeltf, plateNum: platetf, vehicleId: Int.random(in: 100..<99999), completion: { check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Vehicle Added Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                            self.vehicleDetailsViewModel?.getData()
                        }
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Vehicle Add Error !!!", message: nil, preferredStyle: .alert)
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
    
    
    
    @objc func addNewVehicleButtonTapped(){
        addNewVehicle()
    }
    
    
    
}
