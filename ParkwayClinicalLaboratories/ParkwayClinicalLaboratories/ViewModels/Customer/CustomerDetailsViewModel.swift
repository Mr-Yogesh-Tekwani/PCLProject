//
//  CustomerDetailsViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit

class CustomerDetailsViewModel {
    
    var allCustomersArray : GetCustomerArray?
    weak var customerDetailsViewController : CustomerDetailsViewController?
    var clientManager = ClientManager()
    
    
    func makeVc() -> UIViewController {
        let vc = CustomerDetailsViewController()
        self.customerDetailsViewController = vc
        vc.customerDetailsViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getCustomer(completion: { data in
            self.allCustomersArray = data
            self.customerDetailsViewController?.allCustomersArray = data
            //print(data)
        })
    }
    
}
