//
//  GetRouteDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

// MARK: - Used for GetRouteDecoder, GetRouteDetailDecoder
/*
struct GetRouteDecoder: Codable {
    let route: Route?

    enum CodingKeys: String, CodingKey {
        case route = "Route"
    }
}

enum State: String, Codable {
    case empty = ""
    case nj = "NJ"
    case ny = "NY"
    case pa = "PA"
}

// MARK: - Route
struct Route: Codable {
    let routeNo: Int?
    let routeName: String?
    let driverID: Int?
    let driverName, vehicleNo: String?

    enum CodingKeys: String, CodingKey {
        case routeNo = "RouteNo"
        case routeName = "RouteName"
        case driverID = "DriverId"
        case driverName = "DriverName"
        case vehicleNo = "VehicleNo"
    }
}

typealias GetRouteArray = [GetRouteDecoder]
*/


import Foundation

// MARK: - GetRouteDecoderElement
struct GetRouteDecoder: Codable {
    let route: Route?
    let customer: [Customer]?

    enum CodingKeys: String, CodingKey {
        case route = "Route"
        case customer = "Customer"
    }
}

// MARK: - Customer
struct Customer: Codable {
    let CustomerId: Int
    let CustomerName: String?
}



enum State: String, Codable {
    case empty = ""
    case nj = "NJ"
    case ny = "NY"
    case pa = "PA"
}

// MARK: - Route
struct Route: Codable {
    let routeNo: Int?
    let routeName: String?
    let driverID: Int?
    let driverName, vehicleNo: String?

    enum CodingKeys: String, CodingKey {
        case routeNo = "RouteNo"
        case routeName = "RouteName"
        case driverID = "DriverId"
        case driverName = "DriverName"
        case vehicleNo = "VehicleNo"
    }
}

typealias GetRouteArray = [GetRouteDecoder]

