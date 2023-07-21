//
//  AdminHomeDetailsViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit

class AdminHomeDetailsViewModel {
    
    var allAdminArray : GetDetailForAdminArray?
    weak var adminHomeDetailsViewController : AdminHomeDetailsViewController?
    var clientManager = ClientManager()
    
    
    func makeVc() -> UIViewController {
        let vc = AdminHomeDetailsViewController()
        self.adminHomeDetailsViewController = vc
        vc.adminHomeDetailsViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getDetailForAdmin(completion: { data in
            self.allAdminArray = data
        })
    }
    
}
