//
//  CustomerDetailsViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit
import CoreLocation

class CustomerDetailsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var customerDetailsViewModel : CustomerDetailsViewModel?
    var clientManager = ClientManager()
    var allCustomersArray: GetCustomerArray? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerDetailsViewModel?.getData()
        self.title = "Customer Details"
        // Add the "+" button to the navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCustomerButtonTapped))
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
        return allCustomersArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = allCustomersArray?[indexPath.row].customerName ?? ""
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(allCustomersArray?[indexPath.row].pickUpTime)
        showUpdateCustomerPopup(
            custId: allCustomersArray?[indexPath.row].customerID ?? 0,
            city: allCustomersArray?[indexPath.row].city ?? "",
            cust_lad: allCustomersArray?[indexPath.row].custLat  ?? 0.0,
            cust_log: allCustomersArray?[indexPath.row].custLog ?? 0.0,
            custName: allCustomersArray?[indexPath.row].customerName  ?? "",
            pickUpTime: allCustomersArray?[indexPath.row].pickUpTime  ?? "",
            state: allCustomersArray?[indexPath.row].state  ?? "",
            street: allCustomersArray?[indexPath.row].streetAddress  ?? "",
            zip: Int((allCustomersArray?[indexPath.row].zip)!) ?? 000)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the element from the dataArray
            guard let cid = allCustomersArray?[indexPath.row].customerID
            else{
                return
            }
            
            clientManager.deleteCustomer(cId: cid, completion: { check in
                if check == true {
                    DispatchQueue.main.async {
                        self.customerDetailsViewModel?.getData()
                        let alertController = UIAlertController(title: "Customer Deleted Successfully !", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Unable to delete customer.Customer in active route !!!", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
            })
            
        }
        
    }
    
    
    // MARK: Customer Update Pop up
    
    // Function to show the Update Driver pop-up with pre-filled values
    func showUpdateCustomerPopup(custId: Int, city: String?, cust_lad: Double?, cust_log: Double?, custName: String?, pickUpTime: String?, state: String?, street: String?, zip: Int?) {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        // Create text fields for first name, last name, and mobile number with the provided values
        alertController.addTextField { textField in
            textField.text = custName
            textField.placeholder = "Customer Name"
        }
        
        alertController.addTextField { textField in
            textField.text = street
            textField.placeholder = "Street"
        }
        
        alertController.addTextField { textField in
            textField.text = city
            textField.placeholder = "City"
        }
        
        alertController.addTextField { textField in
            textField.text = state
            textField.placeholder = "State"
        }
        
        alertController.addTextField { textField in
            textField.text = String(zip ?? 0)
            textField.placeholder = "Zip"
            textField.keyboardType = .phonePad
        }
        
        
        // Create a time picker
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        
        guard let dateString = pickUpTime else {
            print("Date Errorr")
            return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        // Parse the date string into a Date object
        if let defaultDate = dateFormatter.date(from: dateString) {
            // Set the default date for the date picker
            timePicker.date = defaultDate
        }
    
   
        
        alertController.view.addSubview(timePicker)
        
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
                        
        
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.showUpdateCustomerPopup(custId: custId, city: city, cust_lad: cust_lad, cust_log: cust_log, custName: custName, pickUpTime: pickUpTime, state: state, street: street, zip: zip)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let nametf = alertController.textFields?[0].text,
               let streettf = alertController.textFields?[1].text,
               let citytf = alertController.textFields?[2].text,
               let statetf = alertController.textFields?[3].text,
               let ziptf = alertController.textFields?[4].text
                
            {
                
                let selectedTime = timePicker.date
                
                // Handle the selected time as needed
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                let formattedTime = dateFormatter.string(from: selectedTime)
                
                print("Selected time: \(formattedTime) for \(nametf)")
                
                
                self.clientManager.updateCustomer(custId: custId, city: citytf, cust_lad: cust_lad, cust_log: cust_log, custName: nametf, pickUpTime: formattedTime, state: statetf, street: streettf, zip: Int(ziptf), completion: { check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Customer Updated Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                            self.customerDetailsViewModel?.getData()
                        }
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Customer Update Error !!!", message: nil, preferredStyle: .alert)
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
    
    
    
    // MARK: Add New Customer Pop up
    
    // Function to show the Update Driver pop-up
    func addNewCustomerPopup() {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        // Create text fields for first name, last name, and mobile number with the provided values
        alertController.addTextField { textField in
            textField.placeholder = "Customer Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Street"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "City"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "State"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Zip"
            textField.keyboardType = .phonePad
        }
        
        
        // Create a time picker
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        alertController.view.addSubview(timePicker)
        
        
        // Add actions for the Reset, Cancel, and Submit buttons
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            // Clear text fields when Reset is tapped
            alertController.textFields?.forEach { textField in
                textField.text = ""
                self.addNewCustomerPopup()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Access the text fields and get user input when Submit is tapped
            if let nametf = alertController.textFields?[0].text,
               let streettf = alertController.textFields?[1].text,
               let citytf = alertController.textFields?[2].text,
               let statetf = alertController.textFields?[3].text,
               let ziptf = alertController.textFields?[4].text
                
            {
                
                let selectedTime = timePicker.date
                
                // Handle the selected time as needed
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                let formattedTime = dateFormatter.string(from: selectedTime)
                
                print("Selected time: \(formattedTime)")
                
                // Code to get current Lat and Log
                let locationManager = CLLocationManager()
                var latitude = 0.0
                var longitude = 0.0
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                if let location = locationManager.location {
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                    print("Latitude: \(latitude), Longitude: \(longitude)")
                }
                
                self.clientManager.addCustomer(city: citytf, cust_lad: latitude, cust_log: longitude, custName: nametf, pickUpTime: formattedTime, state: statetf, street: streettf, zip: Int(ziptf), completion:{ check in
                    
                    if check == true {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Customer Created Successfully !", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        self.customerDetailsViewModel?.getData()
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Customer Create Error !!!", message: nil, preferredStyle: .alert)
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
    
    // Function to call when the Update Customer button is tapped
    @objc func addNewCustomerButtonTapped(_ sender: UIButton) {
        addNewCustomerPopup()
    }
    
    
}


