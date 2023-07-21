//
//  GetLatestRouteNumberDecoder.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

// MARK: - GetLatestRouteNumberDecoder
struct GetLatestRouteNumberDecoder: Codable {
    let routeNo: Int

    enum CodingKeys: String, CodingKey {
        case routeNo = "RouteNo"
    }
}
