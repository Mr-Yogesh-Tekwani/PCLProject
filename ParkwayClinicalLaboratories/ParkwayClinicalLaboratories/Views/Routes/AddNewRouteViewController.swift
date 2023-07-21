//
//  AddNewRouteViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class AddNewRouteViewController: UIViewController, VehicleDelegate, DriverDelegate, CustomerDelegate {
    
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
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.backgroundColor = .white
        return sv
    }()
    
    var selectedVehicle : String?
    var selectedDriver : String?
    var selectedCustomer : String?
    
    var cidRecieved: Int?
    var driverIdRecieved : Int?
    var clientManager = ClientManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        mainStack.addArrangedSubview(routeNameTextField)
        mainStack.addArrangedSubview(routeIdTextField)
        mainStack.addArrangedSubview(driverButton)
        mainStack.addArrangedSubview(vehicleButton)
        mainStack.addArrangedSubview(customerButton)
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
              let text = text
        else {
            showAlert(message: "Please Fill in All Fields !!!")
            return
        }
        
        clientManager.addRoute(custId: cidRecieved, driverId: driverIdRecieved, routeName: text, vehicleNo: selectedVehicle, completion: { check in
                
                if check == true{
                    DispatchQueue.main.async {
                    self.showAlert(message: "Add Route Success !!!")
                    }
                }
                else{
                    DispatchQueue.main.async {
                    self.showAlert(message: "Customer / Driver already assigned !!!")
                    }
                }
                
            })
        
    }
    
    
}
