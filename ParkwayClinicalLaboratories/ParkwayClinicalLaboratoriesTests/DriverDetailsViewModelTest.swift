//
//  DriverDetailsViewModelTest.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class DriverDetailsViewModelTest: XCTestCase{

    func testInit() throws {
        let driverDetailsVm = DriverDetailsViewModel()
        let _ = try XCTUnwrap(driverDetailsVm.makeVc() as UIViewController)
    }
}
