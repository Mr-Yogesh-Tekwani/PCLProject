//
//  GetAvailableDriverDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

// MARK: - GetAvailableDriverDecoder and GetDriver

struct GetAvailableDriverDecoder: Codable {
    let driverID: Int?
    let driverName, phoneNumber: String?

    enum CodingKeys: String, CodingKey {
        case driverID = "DriverId"
        case driverName = "DriverName"
        case phoneNumber = "PhoneNumber"
    }
}

typealias GetAvailableDriverArray = [GetAvailableDriverDecoder]


