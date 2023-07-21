//
//  DriverDetailsViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import Foundation
import UIKit

class DriverDetailsViewModel {
    
    var allDriversArray : GetAvailableDriverArray?
    weak var driverDetailsViewController : DriverDetailsViewController?
    var clientManager = ClientManager()
    
    
    func makeVc() -> UIViewController {
        let vc = DriverDetailsViewController()
        self.driverDetailsViewController = vc
        vc.driverDetailsViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getDriver(completion: { data in
            self.allDriversArray = data
            self.driverDetailsViewController?.allDriversArray = data
            //print(data)
        })
    }
    
}
