//
//  RouteDetailsViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class RouteDetailsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var routeDetailsViewModel : RouteDetailsViewModel?
    var allRouteArray : GetRouteArray?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var clientManager = ClientManager()
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Reload data every time the view is about to appear
        routeDetailsViewModel?.getData()
            tableView.reloadData()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeDetailsViewModel?.getData()
        view.backgroundColor = .white
        title = "Route Details"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRouteButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RouteDetailsTableViewCell.self, forCellReuseIdentifier: RouteDetailsTableViewCell.identifier)
        tableView.reloadData()
        
        // Configure and add the table view to the view hierarchy
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRouteArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  RouteDetailsTableViewCell.identifier) as? RouteDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.routeIdLabel.text = "Route Id"
        cell.routeId.text = "\(allRouteArray?[indexPath.row].route?.routeNo ?? 0)"
        
        cell.routeNameLabel.text = "Route Name"
        cell.routeName.text = allRouteArray?[indexPath.row].route?.routeName ?? ""
        
        cell.driverNameLabel.text = "Driver Name"
        cell.driverName.text = allRouteArray?[indexPath.row].route?.driverName ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let svc = EditRouteViewController()
        svc.selectedRoute = allRouteArray?[indexPath.row]
        navigationController?.pushViewController(svc, animated: true)
        
    }
    
    
    // MARK: Delete Route
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the element from the dataArray
            guard let rid = allRouteArray?[indexPath.row].route?.routeNo
            else{
                return
            }
            
            clientManager.deleteRoute(routeNum: rid, completion: { check in
                if check == true {
                    DispatchQueue.main.async {
                        self.routeDetailsViewModel?.getData()
                        let alertController = UIAlertController(title: "Route Deleted Successfully !", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Unable to delete route.Route is in progress right now. !!!", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
            })
            
        }
        
    }
    
    
    @objc func addNewRouteButtonTapped(){
        let svc = AddNewRouteViewController()
        navigationController?.pushViewController(svc, animated: true)
    }
    
    
    
}
