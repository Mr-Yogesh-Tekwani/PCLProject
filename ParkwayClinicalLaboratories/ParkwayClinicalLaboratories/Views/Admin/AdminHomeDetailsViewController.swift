//
//  AdminHomeDetailsViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit
import MapKit
import CoreLocation

class AdminHomeDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var adminHomeDetailsViewModel : AdminHomeDetailsViewModel?
    let tableView = UITableView()
    var selectedAdmin : GetDetailForAdminDecoder?
    var custList : GetCustomerArray?{
        didSet{
            for i in 0..<(self.custList?.count ?? 0){
                print("Inside For Loop")
                if custList?[i].customerID == self.selectedAdmin?.customerID {
                    self.cust = self.custList?[i]
                    print(cust)
                }
               
            }
        }
    }
    var cust : GetCustomerDecoder?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let latitude: CLLocationDegrees = 37
    let longitude: CLLocationDegrees = -122
    let geofence: Bool = false
    
    let clientManager = ClientManager()
    
    let mainStack: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 5
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Driver Details"
        
        DispatchQueue.main.async {
            self.clientManager.getCustomer(completion: { data in
                self.custList = data
            })
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AdminHomeDetailsTableViewCell.self, forCellReuseIdentifier: AdminHomeDetailsTableViewCell.identifier)
        
        // Configure and add the table view to the view hierarchy
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainStack.addArrangedSubview(tableView)
        
        
        let mapView = MKMapView()
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the initial region to display the specified location
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // Optionally, add a circular overlay for the geofence
        if geofence {
            let circle = MKCircle(center: location, radius: 200)
            mapView.addOverlay(circle)
        }
        
        
        // Create a custom MKPointAnnotation for the location
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        // Add the annotation to the map
        mapView.addAnnotation(annotation)
        
        mainStack.addArrangedSubview(mapView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mapView.heightAnchor.constraint(equalToConstant: 500),
            mapView.widthAnchor.constraint(equalToConstant: 100),
            mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
            
        ])
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  AdminHomeDetailsTableViewCell.identifier) as? AdminHomeDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        
        
        cell.clientName.text = cust?.customerName
        cell.clientAddress.text = cust?.streetAddress
        cell.specCollectedLabel.text = "Specimens Collected\n\n\n\n \(cust?.specimenCount ?? 0)"
        
        cell.specCollectedLabel.numberOfLines = 0
        cell.specCollectedLabel.lineBreakMode = .byWordWrapping
        
        cell.pickedUpAtTime.text = "Time \n\n\n\n \(cust?.pickUpTime ?? "")"
        
        cell.pickedUpAtTime.numberOfLines = 0
        cell.pickedUpAtTime.lineBreakMode = .byWordWrapping
        
        cell.noOfSpecLabel.text = "Route ID \n\n\n\n \(selectedAdmin?.routeNo ?? 0)"
        cell.noOfSpecLabel.numberOfLines = 0
        cell.noOfSpecLabel.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
    
}


extension AdminHomeDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            // Return nil for the user location annotation
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
        annotationView.image = UIImage(named: "greendot")
        // Set your custom location icon image here
        annotationView.canShowCallout = true
        
        return annotationView
    }
    
    
}
