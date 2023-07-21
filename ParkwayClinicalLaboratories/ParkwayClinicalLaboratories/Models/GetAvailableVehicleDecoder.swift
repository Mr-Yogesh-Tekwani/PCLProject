//
//  GetAvailableVehicleDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

// MARK: - GetAvailableVehicle and GetVehicle


struct GetAvailableVehicleDecoder: Codable {
    let vehicleID: Int?
    let plateNumber, manufacturer, model: String?

    enum CodingKeys: String, CodingKey {
        case vehicleID = "VehicleId"
        case plateNumber = "PlateNumber"
        case manufacturer = "Manufacturer"
        case model = "Model"
    }
}

typealias GetAvailableVehicleArray = [GetAvailableVehicleDecoder]
