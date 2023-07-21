//
//  MockNetwork.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import XCTest
@testable import ParkwayClinicalLaboratories
import Foundation


enum JsonFiles: String {
    case AddCustomerResults
    case DeleteCustomerResults
    case GetAvailableCustomerResults
    case UpdateCustomerResults
    case LoginResults
    case AddRouteResults
    case DeleteRouteResults
    case GetLatestRouteNumberResults
    case GetRouteResults
    case GetTotalSpecimensResults
    case AddDriverResults
    case DeleteDriverResults
    case GetDriverResults
    case GetDriverLocationResults
    case UpdateDriverResults
    case AddVehicleResults
    case DeleteVehicleResults
    case GetVehicleResults
    case UpdateVehicleResults
    
    
    

    init?(url: URL, failedURL: Bool) {
        switch url {
        case let x where  x == addCustomerUrl:
            self = .AddCustomerResults
            
        case let x where  x == makeDeleteCustomerUrl(custId: 123):
            self = .DeleteCustomerResults
            
        case let x where  x == getAvailableCustomerUrl:
            self = .GetAvailableCustomerResults
            
            
        case let x where  x == updateCustomerUrl:
            self = .UpdateCustomerResults

            
        case let x where  x == userLoginUrl:
            self = .LoginResults
            
        case let x where  x == addRouteUrl :
            self = .AddRouteResults
        
            
        case let x where  x == makeDeleteRouteUrl(routeNumber: 85) :
            self = .DeleteRouteResults
            
        case let x where  x == getLatestRouteNumberUrl :
            self = .GetLatestRouteNumberResults
            
        case let x where  x == getRouteUrl :
            self = .GetRouteResults
            
        case let x where  x == getTotalSpecimensCollectedUrl :
            self = .GetTotalSpecimensResults
            
        case let x where  x == addDriverUrl :
            self = .AddDriverResults
            
        case let x where  x.absoluteString.contains("/Driver/DeleteDriver/") :
            self = .DeleteDriverResults
            
            
        case let x where  x == getDriverUrl :
            self = .GetDriverResults
            
        case let x where  x == makeGetDriverLocationUrl(driverId: 129) :
            self = .GetDriverLocationResults
            
        case let x where  x == updateDriverUrl :
            self = .UpdateDriverResults
            
        case let x where  x == addVehicleUrl :
            self = .AddVehicleResults
            
        case let x where  x.absoluteString.contains("/vehicle/DeleteVehicle") :
            self = .DeleteVehicleResults
            
        case let x where  x == getVehicleUrl :
            self = .GetVehicleResults
         
        case let x where  x == updateVehicleUrl :
            self = .UpdateVehicleResults
            
        default:
            return nil
        }
    }
}



class MockNetwork: NetworkProtocol {
    
    var AllFailedURLS: Bool = false
    
    func getData(urlRequest: URLRequest,
                 completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = urlRequest.url,
              let file = JsonFiles(url: url,
                                   failedURL: AllFailedURLS) else {
            completion(nil,nil,nil)
            return
        }
        
        let bundle = Bundle(for: MockNetwork.self)
        if let path = bundle.path(forResource: file.rawValue,
                                       ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                let response = HTTPURLResponse(url: url,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
                completion(data, response, nil)
            }catch {
                completion(nil,nil,nil)
            }
        } else {
            completion(nil,nil,nil)
        }
        
    }
}
