//
//  GetAvailableCustomerDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation


// MARK: - Get Available Customer Decoder

struct GetAvailableCustomerDecoder: Codable {
    let customerID: Int?
    let customerName, streetAddress, city, state: String?
    let zip, collectionStatus: String?
    let specimenCount: Int?
    let pickUpTime: String?
    let isSelected: Bool?
    let custLat, custLog: Double?

    enum CodingKeys: String, CodingKey {
        case customerID = "CustomerId"
        case customerName = "CustomerName"
        case streetAddress = "StreetAddress"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case collectionStatus = "CollectionStatus"
        case specimenCount = "SpecimenCount"
        case pickUpTime = "PickUpTime"
        case isSelected = "IsSelected"
        case custLat = "Cust_Lat"
        case custLog = "Cust_Log"
    }
}

typealias GetAvailableCustomerArray = [GetAvailableCustomerDecoder]

