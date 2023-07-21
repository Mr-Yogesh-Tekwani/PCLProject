//
//  AdminHomeViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit

class AdminHomeViewModel {
    
    var allAdminArray : GetDetailForAdminArray?
    weak var adminHomeViewController : HomeController?
    var clientManager = ClientManager()
    
    
    func makeVc() -> UIViewController {
        let vc = HomeController()
        self.adminHomeViewController = vc
        vc.adminHomeViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getDetailForAdmin(completion: { data in
            self.allAdminArray = data
            self.adminHomeViewController?.allAdminArray = data
        })
    }
    
}
