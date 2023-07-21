//
//  AdminHomeViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/14/23.
//

import Foundation

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var adminHomeViewModel : AdminHomeViewModel?
    var allAdminArray : GetDetailForAdminArray?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    let tableView = UITableView()
    let totalSpecimensLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminHomeViewModel?.getData()
        
        view.backgroundColor = .white
        title = "Home"
        let titleView = UIImageView (image: UIImage (named: "PCL"))
        titleView.contentMode = .scaleAspectFit
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = titleView
        tableView.register(AdminHomeTableViewCell.self, forCellReuseIdentifier: AdminHomeTableViewCell.identifier)
        tableView.reloadData()
        
        // Configure and add the table view to the view hierarchy
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalSpecimensLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        adminHomeViewModel?.clientManager.getTotalSpecimensCollected(completion: { total in
            
            DispatchQueue.main.async {
                self.totalSpecimensLabel.text = "Total Specimens = \(Int(total?.TotalNumberOfSpecimens ?? 0))"
            }
        })
        
        
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(reloadData), userInfo: nil, repeats: true)
        timer.fire()
        
        
        view.addSubview(tableView)
        view.addSubview(totalSpecimensLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalSpecimensLabel.topAnchor, constant: -8), // Add spacing between table view and label
            
            totalSpecimensLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalSpecimensLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalSpecimensLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalSpecimensLabel.heightAnchor.constraint(equalToConstant: 40) // Adjust the label height as needed
        ])
    }
    
    @objc private func reloadData() {

        adminHomeViewModel?.getData()
        adminHomeViewModel?.clientManager.getTotalSpecimensCollected(completion: { total in
            
            DispatchQueue.main.async {
                self.totalSpecimensLabel.text = "Total Specimens = \(Int(total?.TotalNumberOfSpecimens ?? 0))"
            }
        })
        print("Data Refreshed !")
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAdminArray?.count ?? 1
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  AdminHomeTableViewCell.identifier) as? AdminHomeTableViewCell else {
                return UITableViewCell()
            }
            cell.routeNoLabel.text = "Route No"
            cell.routeNoTextLabel.text = "\(allAdminArray?[indexPath.row].routeNo ?? 0)"
            cell.accountStatusLabel.text = "Account Status"
            cell.pickedUpAtLabel.text = "Picked-up at"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd h:mm a"
            
            if let date = dateFormatter.date(from: allAdminArray?[indexPath.row].pickUpTime ?? "") {
                dateFormatter.dateFormat = "h:mm a"
                cell.pickedUpAtTime.text = dateFormatter.string(from:date)
            }
            else{
                cell.pickedUpAtTime.text = allAdminArray?[indexPath.row].pickUpTime
            }

            cell.pickedUpByLabel.text = "Picked-up by"
            cell.pickedUpByTextLabel.text = allAdminArray?[indexPath.row].updatedByDriver
            cell.specimenLabel.text = "Specimen Collected"
            cell.specimenTextLabel.text = "\(allAdminArray?[indexPath.row].numberOfSpecimens ?? 0)"
            cell.onTimeorNot.text = "On Time"
            return cell
        }
    
    
    
    // MARK: UI TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let svc = AdminHomeDetailsViewController()
        svc.selectedAdmin = allAdminArray?[indexPath.row]
        navigationController?.pushViewController(svc, animated: true)
    }

    
}

class SettingsController: UIViewController {
    
    let mainStack : UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        //sv.spacing = 150
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.backgroundColor = .white
        return sv
    }()
    
    
    let driverButton : UIButton = {
        let b = UIButton()
        b.setTitle("Driver", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        b.isUserInteractionEnabled = true
        return b
    }()
    
    let customerButton : UIButton = {
        let b = UIButton()
        b.setTitle("Customer", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        return b
    }()
    
    let vehicleButton : UIButton = {
        let b = UIButton()
        b.setTitle("Vehicle", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        return b
    }()
    
    let routesButton : UIButton = {
        let b = UIButton()
        b.setTitle("Routes", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        //b.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        
        // Create a UIImageView with your desired image
        let imageView = UIImageView(image: UIImage(named: "PCL"))
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(driverButton)
        mainStack.addArrangedSubview(customerButton)
        mainStack.addArrangedSubview(vehicleButton)
        mainStack.addArrangedSubview(routesButton)
        
        driverButton.addTarget(self, action: #selector(driverClicked), for: .touchUpInside)
        customerButton.addTarget(self, action: #selector(customerClicked), for: .touchUpInside)
        vehicleButton.addTarget(self, action: #selector(vehicleClicked), for: .touchUpInside)
        routesButton.addTarget(self, action: #selector(routeClicked), for: .touchUpInside)
        
        
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
    
    @objc func driverClicked(){
        let svc = DriverDetailsViewModel().makeVc()
        self.navigationController?.pushViewController(svc, animated: true)
    }

    @objc func customerClicked(){
        let svc = CustomerDetailsViewModel().makeVc()
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    @objc func vehicleClicked(){
        let svc = VehicleDetailsViewModel().makeVc()
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    @objc func routeClicked(){
        let svc = RouteDetailsViewModel().makeVc()
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    
}

class AdminHomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = UINavigationController(rootViewController: AdminHomeViewModel().makeVc())
        homeController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        
        let settingsController = UINavigationController(rootViewController: SettingsController())
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        
        viewControllers = [homeController, settingsController]
        
        // Customize the appearance of the tab bar items
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        // Customize the appearance of the tab bar
        tabBar.tintColor = .white
        tabBar.barTintColor = .blue
        tabBar.isTranslucent = false
        tabBar.itemWidth = 150
        tabBar.itemPositioning = .centered
    }
}
