//
//  VehicleDetailsViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit
import Foundation

class VehicleDetailsViewModel {


    weak var vehicleDetailsViewController : VehicleDetailsViewController?
    var allVehicleArray : GetAvailableVehicleArray?
    
    var clientManager = ClientManager()
    
    func makeVc() -> UIViewController {
        let vc = VehicleDetailsViewController()
        self.vehicleDetailsViewController = vc
        vc.vehicleDetailsViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getVehicle(completion: { data in
            self.allVehicleArray = data
            self.vehicleDetailsViewController?.allVehicleArray = data
        })
    }
    


}
