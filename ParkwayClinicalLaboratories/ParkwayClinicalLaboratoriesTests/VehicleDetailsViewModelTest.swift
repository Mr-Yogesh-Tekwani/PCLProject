//
//  VehicleDetailsViewModelTest.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class VehicleDetailsViewModelTest: XCTestCase{

    func testInit() throws {
        let vehicleDetailsVm = VehicleDetailsViewModel()
        let _ = try XCTUnwrap(vehicleDetailsVm.makeVc() as UIViewController)
    }
}
