//
//  RouteDetailsViewModel.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class RouteDetailsViewModel {

    weak var routeDetailsViewController : RouteDetailsViewController?
    var allRouteArray : GetRouteArray?
    var clientManager = ClientManager()
    
    
    func makeVc() -> UIViewController {
        let vc = RouteDetailsViewController()
        self.routeDetailsViewController = vc
        vc.routeDetailsViewModel = self
        return vc
    }
    
    
    func getData() {
        clientManager.getRoute(completion: { data in
            self.allRouteArray = data
            self.routeDetailsViewController?.allRouteArray = data
        })
    }
    

}
