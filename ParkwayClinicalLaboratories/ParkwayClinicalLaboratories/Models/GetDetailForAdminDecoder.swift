//
//  GetAdminDetailsDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

import Foundation

// MARK: - GetDetailForAdminDecoder
struct GetDetailForAdminDecoder: Codable {
    let tranID, routeNo, customerID, status: Int?
    let pickUpDt, pickUpTime: String?
    let numberOfSpecimens: Int?
    let createdDate, updatedByDriver: String?

    enum CodingKeys: String, CodingKey {
        case tranID = "TranId"
        case routeNo = "RouteNo"
        case customerID = "CustomerId"
        case status = "Status"
        case pickUpDt = "PickUp_Dt"
        case pickUpTime = "PickUp_Time"
        case numberOfSpecimens = "NumberOfSpecimens"
        case createdDate = "CreatedDate"
        case updatedByDriver = "UpdatedByDriver"
    }
}

typealias GetDetailForAdminArray = [GetDetailForAdminDecoder]
