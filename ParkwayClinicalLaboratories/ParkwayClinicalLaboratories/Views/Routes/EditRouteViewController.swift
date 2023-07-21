//
//  EditRouteViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class EditRouteViewController: UIViewController, VehicleDelegate, DriverDelegate, CustomerDelegate {
    
    var tableView = UITableView()
    
    let routeNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Route Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let routeIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Route Id"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let driverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Driver", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let vehicleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Vehicle", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let customerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Customer", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let custStack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.backgroundColor = .white
        return sv
    }()
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.backgroundColor = .white
        return sv
    }()
    
    var selectedRoute: GetRouteDecoder?
    var clientManager = ClientManager()
    
    var selectedVehicle : String?
    var selectedDriver : String?
    var selectedCustomer : String?
    var selectedRouteNum: Int?
    var selectedRouteName: String?
    
    var cidRecieved: Int?
    var driverIdRecieved : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableView.dataSource = self
       
        // Set the table view's header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        headerView.backgroundColor = .lightGray
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: headerView.bounds.width + 292, height: headerView.bounds.height))
        titleLabel.text = "Customer Already in the Route"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        tableView.tableHeaderView = headerView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        selectedVehicle = selectedRoute?.route?.vehicleNo ?? ""
        selectedDriver = selectedRoute?.route?.driverName ?? ""
        selectedRouteNum = selectedRoute?.route?.routeNo ?? 00
        selectedRouteName = selectedRoute?.route?.routeName ?? ""
        cidRecieved = selectedRoute?.customer?[0].CustomerId ?? 00
        driverIdRecieved = selectedRoute?.route?.driverID ?? 00
        
        
        routeNameTextField.text = selectedRouteName
        routeIdTextField.text = "\(selectedRouteNum ?? 00)"
        routeIdTextField.isUserInteractionEnabled = false
        driverButton.setTitle(selectedDriver, for: .normal)
        vehicleButton.setTitle(selectedVehicle, for: .normal)
        
        mainStack.addArrangedSubview(routeNameTextField)
        mainStack.addArrangedSubview(routeIdTextField)
        mainStack.addArrangedSubview(driverButton)
        mainStack.addArrangedSubview(vehicleButton)
        custStack.addArrangedSubview(customerButton)
        custStack.addArrangedSubview(tableView)
        mainStack.addArrangedSubview(custStack)
        mainStack.addArrangedSubview(submitButton)
        
        driverButton.addTarget(self, action: #selector(driverClicked), for: .touchUpInside)
        vehicleButton.addTarget(self, action: #selector(vehicleClicked), for: .touchUpInside)
        customerButton.addTarget(self, action: #selector(customerClicked), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            
        ])
    }
    
    func vehicleDataRecieved(_ viewController2: SelectVehicleViewController, didReturnData data: String) {
        print("Selected Vehicle: \(data)")
        selectedVehicle = data
        self.vehicleButton.setTitle(selectedVehicle, for: .normal)
    }
    
    func driverDataRecieved(_ viewController2: SelectDriverViewController, didReturnData data: String, driverId: Int) {
        print("Selected Driver: \(data)")
        selectedDriver = data
        driverIdRecieved = driverId
        self.driverButton.setTitle(selectedDriver, for: .normal)
    }
    
    func customerDataRecieved(_ viewController2: SelectCustomerViewController, didReturnData data: String, cid: Int) {
        print("Selected Customer: \(data)")
        selectedCustomer = data
        cidRecieved = cid
        
        if selectedRoute?.customer?.count != 0 {
            print(selectedRoute?.customer)
            for i in 0..<(selectedRoute?.customer!.count)! {
                if selectedRoute?.customer?[i].CustomerId == cidRecieved{
                    showAlert(message: "Customer Already assigned to a Route !!!!")
                }
            }
            
        }else {return}
        
        self.customerButton.setTitle(selectedCustomer, for: .normal)
    }
    
    @objc func driverClicked(){
        let dest = SelectDriverViewController()
        dest.delegate = self
        self.navigationController?.present(dest, animated: true, completion: nil)
    }
    
    @objc func vehicleClicked(){
        
        let dest = SelectVehicleViewController()
        dest.delegate = self
        self.navigationController?.present(dest, animated: true, completion: nil)
        
    }
    
    
    @objc func customerClicked(){
        
        let dest = SelectCustomerViewController()
        dest.delegate = self
        self.navigationController?.present(dest, animated: true, completion: nil)
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func submitButtonClicked(){
        
        let text = routeNameTextField.text
        guard let cidRecieved = cidRecieved,
              let driverIdRecieved = driverIdRecieved,
              let selectedVehicle = selectedVehicle,
              let selectedRouteNum = selectedRouteNum,
              let text = text
        else {
            showAlert(message: "Please Fill in All Fields !!!")
            return
        }
        
        clientManager.editRoute(custId: cidRecieved, driverId: driverIdRecieved, routeName: text, routeNo: selectedRouteNum, vehicleNo: selectedVehicle, completion: { check in
            
            if check == true{
                DispatchQueue.main.async {
                    self.showAlert(message: "Route Updated Success !!!")
                }
            }
            else{
                DispatchQueue.main.async {
                    self.showAlert(message: "Customer already assigned to Route !!!")
                }
            }
            
        })
        
    }
    
    
}


extension EditRouteViewController: UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedRoute?.customer?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = selectedRoute?.customer?[indexPath.row].CustomerName ?? ""
        return cell
    }
    
    
    
}
