//
//  GetDriverLocationDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

// MARK: - GetDriverLocationDecoder
struct GetDriverLocationDecoder: Codable {
    let lat, log: Double?
    let geofence: Bool?

    enum CodingKeys: String, CodingKey {
        case lat = "Lat"
        case log = "Log"
        case geofence = "Geofence"
    }
}

typealias GetDriverLocationArray = [GetDriverLocationDecoder]
